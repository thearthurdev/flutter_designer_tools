import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_designer_tools/src/grid_overlay.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_designer_tools/src/settings_provider.dart';

class GridOverlaySettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer((context, watch) {
      final provider = watch(settingsProvider);

      bool gridEnabled = provider.gridEnabled;
      Color gridLineColor = provider.gridLineColor;
      double gridXInterval = provider.gridXInterval;
      double gridYInterval = provider.gridYInterval;

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
              onChanged: (b) => provider.toggleGridEnabled(b),
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
                'Overlay a rectangular grid to align your layouts and widgets. Adjust the intervals and color of the lines to suite your needs.',
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
              onTap: () {
                showDialog(
                  context: context,
                  child: SelectColorDialog(provider),
                );
              },
              dense: true,
              title: Text(
                'Line color',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
              trailing: CircleAvatar(
                backgroundColor: gridLineColor,
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
                            value: gridYInterval,
                            onChanged: (value) =>
                                provider.setGridYInterval(value),
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
                                '${gridXInterval.toInt()} x ${gridYInterval.toInt()}',
                                style: TextStyle(
                                    color: Colors.black26, fontSize: 48.0),
                              ),
                            ),
                            GridOverlay(
                              gridLineColor: Colors.blue,
                              gridXInterval: gridXInterval,
                              gridYInterval: gridYInterval,
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
                      value: gridXInterval,
                      onChanged: (value) => provider.setGridXInterval(value),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class SelectColorDialog extends StatelessWidget {
  const SelectColorDialog(this.provider);

  final SettingsProvider provider;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: const Text('Pick a color'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerAreaBorderRadius: BorderRadius.circular(10.0),
          pickerColor: provider.gridLineColor,
          onColorChanged: (color) => provider.setGridLineColor(color),
          showLabel: true,
          pickerAreaHeightPercent: 0.6,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text('Done'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
