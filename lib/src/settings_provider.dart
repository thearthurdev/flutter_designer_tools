import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsProvider = ChangeNotifierProvider((ref) => SettingsProvider());

class SettingsProvider extends ChangeNotifier {
  bool _acceptFOB = false;
  bool _showSettings = false;
  bool _gridEnabled = false;
  bool _mockupEnabled = false;
  Color _gridLineColor = Colors.red;
  double _gridXInterval = 8.0;
  double _gridYInterval = 8.0;
  double _mockupOpacity = 50.0;
  ImageProvider _portraitMockup;
  ImageProvider _landscapeMockup;
  Offset _floatingButtonPosition;

  bool get acceptFOB => _acceptFOB;
  bool get showSettings => _showSettings;
  bool get gridEnabled => _gridEnabled;
  bool get mockupEnabled => _mockupEnabled;
  Color get gridLineColor => _gridLineColor;
  double get gridXInterval => _gridXInterval;
  double get gridYInterval => _gridYInterval;
  double get mockupOpacity => _mockupOpacity;
  ImageProvider get portraitMockup => _portraitMockup;
  ImageProvider get landscapeMockup => _landscapeMockup;
  Offset get floatingButtonPosition => _floatingButtonPosition;

  void toggleAcceptFOB(bool b) {
    _acceptFOB = b;
    notifyListeners();
  }

  void toggleShowSettings(bool b) {
    _showSettings = b;
    notifyListeners();
  }

  void toggleGridEnabled(bool b) {
    _gridEnabled = b;
    notifyListeners();
  }

  void toggleMockupEnabled(bool b) {
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

  void handlePositioning(BuildContext context, {Offset offset}) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    _floatingButtonPosition ??= Offset(deviceWidth - 78.0, deviceHeight - 78.0);

    Offset oldPosition = _floatingButtonPosition;
    double xOffset = offset != null ? offset.dx : oldPosition.dx;
    double yOffset = offset != null ? offset.dy : oldPosition.dy;

    if (xOffset + 68.0 >= deviceWidth) {
      xOffset = deviceWidth - 78.0;
    } else if (xOffset <= 0.0) {
      xOffset = 10.0;
    }

    if (yOffset + 70.0 >= deviceHeight) {
      yOffset = deviceHeight - 78.0;
    } else if (yOffset <= 0.0) {
      yOffset = 10.0;
    }

    if (oldPosition != Offset(xOffset, yOffset)) {
      _floatingButtonPosition = Offset(xOffset, yOffset);
      notifyListeners();
    }
  }
}
