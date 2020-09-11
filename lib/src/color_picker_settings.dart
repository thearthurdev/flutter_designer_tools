import 'package:flutter/material.dart';
import 'package:flutter_designer_tools/src/settings_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorPickerSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      (create, watch) {
        final provider = watch(settingsProvider);

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          padding: EdgeInsets.symmetric(vertical: 8.0),
          constraints: BoxConstraints(maxWidth: 500.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.teal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                value: provider.pickerEnabled,
                onChanged: (b) => provider.togglePickerEnabled(b),
                secondary: Icon(
                  Icons.colorize,
                  color: Colors.white,
                ),
                title: Text(
                  'Color Picker',
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
                  'Pick a color from the Mockup Overlay to ensure that your UI matches perfectly with the design',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
