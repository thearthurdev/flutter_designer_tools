import 'package:flutter/material.dart';
import 'package:flutter_designer_tools/src/floating_settings_button.dart';
import 'package:flutter_designer_tools/src/grid_overlay.dart';
import 'package:flutter_designer_tools/src/mockup_overlay.dart';
import 'package:flutter_designer_tools/src/settings_page.dart';
import 'package:flutter_designer_tools/src/settings_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DesignerTools extends StatelessWidget {
  /// Wrap the layout or widget you want do design with [DesignerTools].
  const DesignerTools({
    Key key,
    @required this.child,
    this.guiEnabled = true,
    this.gridEnabled,
    this.mockupEnabled,
    this.gridLineColor,
    this.gridXInterval,
    this.gridYInterval,
    this.mockupOpacity,
    this.portraitMockup,
    this.landscapeMockup,
  }) : super(key: key);

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
  ///
  /// Must range from 10.0 to 100.0
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
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(
        (context, watch) {
          final provider = watch(settingsProvider);
          provider.handlePositioning(context);

          return Stack(
            children: [
              child,
              mockupEnabled ?? provider.mockupEnabled
                  ? MockupOverlay(
                      mockupOpacity: mockupOpacity,
                      portraitMockup: portraitMockup ?? landscapeMockup,
                      landscapeMockup: landscapeMockup ?? portraitMockup,
                    )
                  : SizedBox(),
              gridEnabled ?? provider.gridEnabled
                  ? GridOverlay(
                      gridLineColor: gridLineColor,
                      gridXInterval: gridXInterval,
                      gridYInterval: gridYInterval,
                    )
                  : SizedBox(),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                reverseDuration: Duration(milliseconds: 200),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeInQuad,
                child: provider.showSettings ? SettingsPage() : SizedBox(),
              ),
              !guiEnabled || provider.acceptFOB
                  ? SizedBox()
                  : Positioned(
                      left: provider.floatingButtonPosition.dx,
                      top: provider.floatingButtonPosition.dy,
                      child: Draggable(
                        onDragEnd: (details) => provider
                            .handlePositioning(context, offset: details.offset),
                        childWhenDragging: SizedBox(),
                        feedback: FloatingSettingsButton(isBeingDragged: true),
                        child: FloatingSettingsButton(
                          onTap: () => provider
                              .toggleShowSettings(!provider.showSettings),
                        ),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
