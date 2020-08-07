import 'package:flutter/material.dart';
import 'package:flutter_designer_tools/flutter_designer_tools.dart';
import 'package:provider/provider.dart';

class DesignerTools extends StatefulWidget {
  /// Wrap the layout or widget you want do design with [DesignerTools].
  const DesignerTools({
    Key key,
    @required this.child,
    this.gridEnabled = false,
    this.mockupEnabled = false,
    this.guiEnabled = true,
    this.gridLineColor = Colors.indigo,
    this.gridXInterval = 8.0,
    this.gridYInterval = 8.0,
    this.mockupOpacity = 50.0,
    this.portraitMockup,
    this.landscapeMockup,
  })  : assert(mockupOpacity >= 10.0 && mockupOpacity <= 100.0,
            'mockupOpacity must range from 10.0 to 100.0'),
        super(key: key);

  /// Widget that is shown below Designer Tools overlays.
  final Widget child;

  /// Whether or not [GridOverlay] is enabled.
  final bool gridEnabled;

  /// Whether or not [MockupOverlay] is enabled.
  final bool mockupEnabled;

  /// Whether or not [FloatingSettingsButton] is enabled.
  ///
  /// When ```true```, user can adjust all settings through a
  /// settings page accessed by tapping on [FloatingSettingsButton]
  final bool guiEnabled;

  /// Color of the grid lines.
  final Color gridLineColor;

  /// Interval between vertical grid lines.
  final double gridXInterval;

  /// Interval between horizontal grid lines.
  final double gridYInterval;

  /// Opacity of [MockupOverlay].
  final double mockupOpacity;

  /// Image for [MockupOverlay] when the device is in portrait mode.
  ///
  /// If ```null``` and ```landscapeMockup``` is set, that image will be used instead.
  final ImageProvider portraitMockup;

  /// Image for [MockupOverlay] when the device is in landscape mode.
  ///
  /// If ```null``` and ```portraitMockup``` is set, that image will be used instead.
  final ImageProvider landscapeMockup;

  @override
  _DesignerToolsState createState() => _DesignerToolsState();
}

class _DesignerToolsState extends State<DesignerTools> {
  Offset _floatingButtonPosition;

  @override
  void initState() {
    super.initState();
    _floatingButtonPosition = Offset.infinite;
  }

  void _handlePositioning({Offset offset}) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    Offset oldPosition = _floatingButtonPosition;
    double xOffset = offset != null ? offset.dx : oldPosition.dx;
    double yOffset = offset != null ? offset.dy : oldPosition.dy;

    if (xOffset + 68.0 >= deviceWidth) {
      xOffset = deviceWidth - 78.0;
    } else if (xOffset <= 0.0) {
      xOffset = 10.0;
    }

    if (yOffset + 70.0 >= deviceHeight) {
      yOffset = deviceHeight - 78.0;
    } else if (yOffset <= 0.0) {
      yOffset = 10.0;
    }

    if (oldPosition != Offset(xOffset, yOffset)) {
      setState(() => _floatingButtonPosition = Offset(xOffset, yOffset));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    _handlePositioning();

    return Provider(
      create: (context) => SettingsProvider(),
      child: Stack(
        children: [
          widget.child,
          widget.mockupEnabled
              ? MockupOverlay(
                  mockupImage: _isPortrait
                      ? widget.portraitMockup ?? widget.landscapeMockup
                      : widget.landscapeMockup ?? widget.portraitMockup,
                  mockupOpacity: widget.mockupOpacity,
                )
              : SizedBox(),
          widget.gridEnabled
              ? GridOverlay(
                  lineColor: widget.gridLineColor,
                  xInterval: widget.gridXInterval,
                  yInterval: widget.gridYInterval,
                )
              : SizedBox(),
          !widget.guiEnabled
              ? SizedBox()
              : Positioned(
                  left: _floatingButtonPosition.dx,
                  top: _floatingButtonPosition.dy,
                  child: Draggable(
                    onDraggableCanceled: (velocity, offset) =>
                        _handlePositioning(offset: offset),
                    childWhenDragging: SizedBox(),
                    feedback: FloatingSettingsButton(isBeingDragged: true),
                    child: Hero(
                      tag: 'FOB',
                      child: FloatingSettingsButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SettingsPage(
                                  gridEnabled: widget.gridEnabled,
                                  mockupEnabled: widget.mockupEnabled,
                                  gridLineColor: widget.gridLineColor,
                                  gridXInterval: widget.gridXInterval,
                                  gridYInterval: widget.gridYInterval,
                                  portraitMockup: widget.portraitMockup,
                                  landscapeMockup: widget.landscapeMockup,
                                  mockupOpacity: widget.mockupOpacity,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
