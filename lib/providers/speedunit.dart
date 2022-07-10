import 'package:flutter/material.dart';
import 'package:weather_app/utils/storage_manager.dart';

class SpeedUnit {
  static final String imperial = 'mph';
  static final String metric = 'km/h';
}

class SpeedUnitNotifier with ChangeNotifier {
  String _speedUnit = SpeedUnit.metric;

  String get getSpeedUnit => _speedUnit;

  SpeedUnitNotifier() {
    StorageManager.readData('speed_unit').then((value) {
      _speedUnit = value ?? SpeedUnit.metric;
      notifyListeners();
    });
  }

  void setSpeedUnit(String unit) async {
    _speedUnit = unit;
    StorageManager.saveData('speed_unit', unit);
    notifyListeners();
  }
}
