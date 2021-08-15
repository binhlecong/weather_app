import 'package:flutter/material.dart';
import 'package:weather_app/utils/storagemanager.dart';

class TempUnitNotifier with ChangeNotifier {
  String _tempUnit = 'C';
  String get getTempUnit => _tempUnit;

  TempUnitNotifier() {
    StorageManager.readData('temp_unit').then((value) {
      // Values are C, F and K
      _tempUnit = value ?? 'C';
      notifyListeners();
    });
  }

  void setTempUnit(String unit) async {
    _tempUnit = unit;
    StorageManager.saveData('temp_unit', unit);
    notifyListeners();
  }
}
