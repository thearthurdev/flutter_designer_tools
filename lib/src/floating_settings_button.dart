import 'package:flutter/material.dart';
import 'package:flutter_designer_tools/src/settings_provider.dart';

class FloatingSettingsButton extends StatelessWidget {
  final SettingsProvider provider;
  final Function onTap, onLongPress;
  final bool isBeingDragged;

  const FloatingSettingsButton({
    Key key,
    this.provider,
    this.onTap,
    this.onLongPress,
    this.isBeingDragged = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 68.0,
          height: 68.0,
          child: Material(
            type: MaterialType.transparency,
            child: Card(
              shape: CircleBorder(),
              elevation: isBeingDragged ? 8.0 : 4.0,
              child: InkWell(
                onTap: onTap,
                onLongPress: onLongPress,
                customBorder: CircleBorder(),
                child: Image.asset(
                  'assets/designer_tools_transparent.png',
                  package: 'flutter_designer_tools',
                  scale: 14.0,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: -8.0,
          top: 18.0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutQuart,
            width: provider.pickerEnabled ? 24.0 : 0.0,
            height: provider.pickerEnabled ? 24.0 : 0.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.teal[600],
            ),
            child: provider.pickerEnabled
                ? Icon(
                    Icons.colorize,
                    color: Colors.white,
                    size: 12.0,
                  )
                : null,
          ),
        ),
        Positioned(
          left: -4.0,
          top: 2.0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutQuart,
            width: provider.mockupEnabled ? 24.0 : 0.0,
            height: provider.mockupEnabled ? 24.0 : 0.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.pink,
            ),
            child: provider.mockupEnabled
                ? Icon(
                    Icons.image,
                    color: Colors.white,
                    size: 12.0,
                  )
                : null,
          ),
        ),
        Positioned(
          left: 10.0,
          top: -8.0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutQuart,
            width: provider.gridEnabled ? 24.0 : 0.0,
            height: provider.gridEnabled ? 24.0 : 0.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.indigo[800],
            ),
            child: provider.gridEnabled
                ? Icon(
                    Icons.grid_on,
                    color: Colors.white,
                    size: 12.0,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
