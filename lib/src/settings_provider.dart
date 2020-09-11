import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsProvider = ChangeNotifierProvider((ref) => SettingsProvider());

class SettingsProvider extends ChangeNotifier {
  bool _acceptFOB = false;
  bool _showSettings = false;
  bool _gridEnabled = false;
  bool _mockupEnabled = false;
  bool _pickerEnabled = false;
  Color _gridLineColor = Colors.red;
  double _gridXInterval = 8.0;
  double _gridYInterval = 8.0;
  double _mockupOpacity = 50.0;
  double _scrollOffset = 0.0;
  ImageProvider _portraitMockup;
  ImageProvider _landscapeMockup;
  Offset _floatingButtonPosition;

  bool get acceptFOB => _acceptFOB;
  bool get showSettings => _showSettings;
  bool get gridEnabled => _gridEnabled;
  bool get mockupEnabled => _mockupEnabled;
  bool get pickerEnabled => _pickerEnabled;
  Color get gridLineColor => _gridLineColor;
  double get gridXInterval => _gridXInterval;
  double get gridYInterval => _gridYInterval;
  double get mockupOpacity => _mockupOpacity;
  ImageProvider get portraitMockup => _portraitMockup;
  ImageProvider get landscapeMockup => _landscapeMockup;
  Offset get floatingButtonPosition => _floatingButtonPosition;
  double get scrollOffset => _scrollOffset;

  void overrideGUISettings(
    bool gridEnabled,
    bool mockupEnabled,
    Color gridLineColor,
    double gridXInterval,
    double gridYInterval,
    double mockupOpacity,
    ImageProvider portraitMockup,
    ImageProvider landscapeMockup,
  ) {
    _gridEnabled = gridEnabled ?? _gridEnabled;
    _mockupEnabled = mockupEnabled ?? _mockupEnabled;
    _gridLineColor = gridLineColor ?? _gridLineColor;
    _gridXInterval = gridXInterval ?? _gridXInterval;
    _gridYInterval = gridYInterval ?? _gridYInterval;
    _mockupOpacity = mockupOpacity ?? _mockupOpacity;
    _portraitMockup = portraitMockup ?? _portraitMockup;
    _landscapeMockup = landscapeMockup ?? _landscapeMockup;
  }

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

  void togglePickerEnabled(bool b) {
    _pickerEnabled = b;
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

  void setPortraitMockup(ImageProvider mockup) {
    _portraitMockup = mockup;
  }

  void setLandscapeMockup(ImageProvider mockup) {
    _landscapeMockup = mockup;
  }

  void setScrollOffset(double offset) {
    _scrollOffset = offset;
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
