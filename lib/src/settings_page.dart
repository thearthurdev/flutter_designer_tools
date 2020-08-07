import 'package:flutter_designer_tools/flutter_designer_tools.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key key,
    this.gridEnabled,
    this.mockupEnabled,
    this.gridLineColor,
    this.gridXInterval,
    this.gridYInterval,
    this.mockupOpacity,
    this.portraitMockup,
    this.landscapeMockup,
  }) : super(key: key);

  final bool gridEnabled;
  final bool mockupEnabled;
  final Color gridLineColor;
  final double gridXInterval;
  final double gridYInterval;
  final double mockupOpacity;
  final ImageProvider portraitMockup;
  final ImageProvider landscapeMockup;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60.0, width: double.infinity),
                SettingsTitle(),
                GridOverlaySettings(
                  gridEnabled: widget.gridEnabled,
                  gridLineColor: widget.gridLineColor,
                  gridXInterval: widget.gridXInterval,
                  gridYInterval: widget.gridYInterval,
                ),
                MockupOverlaySettings(
                  mockupEnabled: widget.mockupEnabled,
                  portraitMockup: widget.portraitMockup,
                  landscapeMockup: widget.landscapeMockup,
                  mockupOpacity: widget.mockupOpacity,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SettingsTitle extends StatelessWidget {
  const SettingsTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
