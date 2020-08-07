import 'package:flutter/material.dart';

class FloatingSettingsButton extends StatelessWidget {
  final Function onTap;
  final bool isBeingDragged;

  const FloatingSettingsButton({
    Key key,
    this.onTap,
    this.isBeingDragged = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68.0,
      height: 68.0,
      child: Material(
        type: MaterialType.transparency,
        child: Card(
          shape: CircleBorder(),
          elevation: isBeingDragged ? 8.0 : 4.0,
          child: InkWell(
            onTap: onTap,
            customBorder: CircleBorder(),
            child: Image.asset(
              'assets/designer_tools_transparent.png',
              package: 'flutter_designer_tools',
              scale: 14.0,
            ),
          ),
        ),
      ),
    );
  }
}
