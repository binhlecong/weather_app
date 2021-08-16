import 'package:flutter/material.dart';
import 'package:weather_app/utils/storagemanager.dart';

class TempUnit {
  static final String kelvin = 'K';
  static final String celsius = 'C';
  static final String fahrenheit = 'F';
}

class TempUnitNotifier with ChangeNotifier {
  String _tempUnit = TempUnit.celsius;
  String get getTempUnit => _tempUnit;

  TempUnitNotifier() {
    StorageManager.readData('temp_unit').then((value) {
      // Values are C, F and K
      _tempUnit = value ?? TempUnit.celsius;
      notifyListeners();
    });
  }

  void setTempUnit(String unit) async {
    _tempUnit = unit;
    StorageManager.saveData('temp_unit', unit);
    notifyListeners();
  }
}
