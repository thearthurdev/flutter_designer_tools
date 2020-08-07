import 'package:flutter/material.dart';

class MockupOverlay extends StatelessWidget {
  final double mockupOpacity;
  final ImageProvider<dynamic> mockupImage;

  const MockupOverlay({
    Key key,
    this.mockupOpacity,
    this.mockupImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Opacity(
        opacity: mockupOpacity / 100.0,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: mockupImage == null
                ? null
                : DecorationImage(
                    image: mockupImage,
                    onError: (exception, stackTrace) {
                      print(exception);
                      print(stackTrace);
                    },
                  ),
          ),
          // child: Image.asset(
          //   'assets/mockup.png',
          //   fit: BoxFit.cover,
          // ),
        ),
      ),
    );
  }
}
