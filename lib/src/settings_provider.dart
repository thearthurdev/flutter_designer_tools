import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  bool gridEnabled = false;
  bool mockupEnabled = false;
  Color gridLineColor = Colors.red;
  double gridXInterval = 8.0;
  double gridYInterval = 8.0;
  double mockupOpacity = 50.0;
  ImageProvider portraitMockup;
  ImageProvider landscapeMockup;

  void toggleGridOverlay(bool b) {
    gridEnabled = b;
    notifyListeners();
  }

  void toggleMockupOverlay(bool b) {
    mockupEnabled = b;
    notifyListeners();
  }

  void setGridLineColor(Color color) {
    gridLineColor = color;
    notifyListeners();
  }

  void setGridXInterval(double xInterval) {
    gridXInterval = xInterval;
    notifyListeners();
  }

  void setGridYInterval(double yInterval) {
    gridYInterval = yInterval;
    notifyListeners();
  }

  void setMockupOpacity(double opacity) {
    mockupOpacity = opacity;
    notifyListeners();
  }
}
