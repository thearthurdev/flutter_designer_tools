import 'package:flutter/material.dart';
import 'package:flutter_designer_tools/src/floating_settings_button.dart';
import 'package:flutter_designer_tools/src/grid_overlay_settings.dart';
import 'package:flutter_designer_tools/src/mockup_overlay_settings.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60.0, width: double.infinity),
                buildSettingsTitle(context),
                GridOverlaySettings(),
                MockupOverlaySettings(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSettingsTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      constraints: BoxConstraints(maxWidth: 520.0),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Designer Tools',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Bring designs to life in Flutter',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.0,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),
          Hero(
            tag: 'FOB',
            child: FloatingSettingsButton(
              onTap: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
