import 'package:flutter/material.dart';
import 'package:flutter_designer_tools/src/grid_overlay_settings.dart';
import 'package:flutter_designer_tools/src/mockup_overlay_settings.dart';
import 'package:flutter_designer_tools/src/floating_settings_button.dart';
import 'package:flutter_designer_tools/src/settings_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      (context, watch) {
        final provider = watch(settingsProvider);

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60.0, width: double.infinity),
                Container(
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
                      DragTarget(
                        onWillAccept: (b) => true,
                        onAccept: (data) => provider.toggleAcceptFOB(true),
                        onLeave: (data) => provider.toggleAcceptFOB(false),
                        builder: (context, want, reject) {
                          return provider.acceptFOB
                              ? FloatingSettingsButton(
                                  onTap: () {
                                    provider.toggleShowSettings(false);
                                    provider.toggleAcceptFOB(false);
                                  },
                                )
                              : Tooltip(
                                  message: 'Stow the Floating Button away here',
                                  waitDuration: Duration(milliseconds: 700),
                                  child: Container(
                                    width: 64.0,
                                    height: 64.0,
                                    margin: EdgeInsets.only(top: 4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      'assets/designer_tools_transparent.png',
                                      package: 'flutter_designer_tools',
                                      color: Colors.grey[400],
                                      scale: 14.0,
                                    ),
                                  ),
                                );
                        },
                      )
                    ],
                  ),
                ),
                GridOverlaySettings(),
                MockupOverlaySettings(),
              ],
            ),
          ),
        );
      },
    );
  }
}
