import 'package:flutter/material.dart';
import 'package:flutter_designer_tools/src/settings_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MockupOverlay extends StatelessWidget {
  final double mockupOpacity;
  final ImageProvider<dynamic> portraitMockup;
  final ImageProvider<dynamic> landscapeMockup;

  const MockupOverlay({
    Key key,
    this.mockupOpacity,
    this.portraitMockup,
    this.landscapeMockup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Consumer((create, watch) {
      final provider = watch(settingsProvider);

      double opacity = mockupOpacity ?? provider.mockupOpacity;

      assert(opacity >= 10.0 && opacity <= 100.0,
          'mockupOpacity must range from 10.0 to 100.0');

      return IgnorePointer(
        child: Opacity(
          opacity: opacity / 100.0,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: portraitMockup == null && landscapeMockup == null
                  ? null
                  : DecorationImage(
                      image: _isPortrait
                          ? portraitMockup ?? provider.landscapeMockup
                          : landscapeMockup ?? provider.portraitMockup,
                      onError: (exception, stackTrace) {
                        print(exception);
                        print(stackTrace);
                      },
                    ),
            ),
          ),
        ),
      );
    });
  }
}
