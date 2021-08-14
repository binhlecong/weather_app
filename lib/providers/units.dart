import 'package:flutter/material.dart';
import 'package:weather_app/utils/storagemanager.dart';

class TempUnitNotifier with ChangeNotifier {
  String tempUnit;
  String get getTempUnit => tempUnit;

  TempUnitNotifier({required this.tempUnit});
  //  {
  //   StorageManager.readData('temp_unit').then((value) {
  //     // Values are C, F and K
  //     _tempUnit = value ?? 'C';
  //     notifyListeners();
  //   });
  // } 

  void setTempUnit(String unit) async {
    tempUnit = unit;
    StorageManager.saveData('temp_unit', unit);
    notifyListeners();
  }
}
