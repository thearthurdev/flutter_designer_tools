import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  bool _gridEnabled = false;
  bool _mockupEnabled = false;
  Color _gridLineColor = Colors.red;
  double _gridXInterval = 8.0;
  double _gridYInterval = 8.0;
  double _mockupOpacity = 50.0;
  ImageProvider _portraitMockup;
  ImageProvider _landscapeMockup;

  bool get gridEnabled => _gridEnabled;
  bool get mockupEnabled => _mockupEnabled;
  Color get gridLineColor => _gridLineColor;
  double get gridXInterval => _gridXInterval;
  double get gridYInterval => _gridYInterval;
  double get mockupOpacity => _mockupOpacity;
  ImageProvider get portraitMockup => _portraitMockup;
  ImageProvider get landscapeMockup => _landscapeMockup;

  void toggleGridOverlay(bool b) {
    _gridEnabled = b;
    notifyListeners();
  }

  void toggleMockupOverlay(bool b) {
    _mockupEnabled = b;
    notifyListeners();
  }

  void setGridLineColor(Color color) {
    _gridLineColor = color;
    notifyListeners();
  }

  void setGridXInterval(double xInterval) {
    _gridXInterval = xInterval;
    notifyListeners();
  }

  void setGridYInterval(double yInterval) {
    _gridYInterval = yInterval;
    notifyListeners();
  }

  void setMockupOpacity(double opacity) {
    _mockupOpacity = opacity;
    notifyListeners();
  }
}
