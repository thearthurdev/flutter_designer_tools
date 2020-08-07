import 'package:flutter_designer_tools/flutter_designer_tools.dart';
import 'package:flutter/material.dart';

class GridOverlaySettings extends StatefulWidget {
  const GridOverlaySettings({
    Key key,
    this.gridEnabled,
    this.gridLineColor,
    this.gridXInterval,
    this.gridYInterval,
  }) : super(key: key);

  final bool gridEnabled;
  final Color gridLineColor;
  final double gridXInterval;
  final double gridYInterval;

  @override
  _GridOverlaySettingsState createState() => _GridOverlaySettingsState();
}

class _GridOverlaySettingsState extends State<GridOverlaySettings> {
  bool gridEnabled;
  Color lineColor;
  double xInterval;
  double yInterval;

  @override
  void initState() {
    super.initState();
    gridEnabled = widget.gridEnabled;
    xInterval = 8.0;
    yInterval = 8.0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      constraints: BoxConstraints(maxWidth: 500.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.indigo,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            value: gridEnabled,
            onChanged: (b) {
              setState(() {
                gridEnabled = b;
              });
            },
            secondary: Icon(
              Icons.grid_on,
              color: Colors.white,
            ),
            title: Text(
              'Grid Overlay',
              maxLines: 2,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Overlay a rectangular grid to align your layouts and widgets. Use the default 8dp x 8dp grid or set a custom grid size. Adjust the color and opacity of the line to suite your needs.',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                height: 1.5,
              ),
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              'Line color',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
            ),
            trailing: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 14.0,
            ),
          ),
          FittedBox(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 160.0,
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Slider(
                          min: 4,
                          max: 24,
                          divisions: 10,
                          value: yInterval,
                          onChanged: (value) {
                            setState(() {
                              yInterval = value.roundToDouble();
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 140.0,
                      width: 240.0,
                      margin: EdgeInsets.fromLTRB(8.0, 8.0, 56.0, 8.0),
                      color: Colors.black12,
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              '${xInterval.toInt()} x ${yInterval.toInt()}',
                              style: TextStyle(
                                  color: Colors.black26, fontSize: 48.0),
                            ),
                          ),
                          GridOverlay(
                            lineColor: Colors.blue,
                            xInterval: xInterval,
                            yInterval: yInterval,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 270.0,
                  margin: EdgeInsets.symmetric(horizontal: 40.0),
                  child: Slider(
                    min: 4,
                    max: 24,
                    divisions: 10,
                    value: xInterval,
                    onChanged: (value) {
                      setState(() {
                        xInterval = value.roundToDouble();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
