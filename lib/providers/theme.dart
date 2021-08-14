import 'package:flutter/material.dart';
import 'package:weather_app/utils/storagemanager.dart';

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData.dark();
  final lightTheme = ThemeData.light();

  ThemeData themeData;
  ThemeData get getTheme => themeData;

  ThemeNotifier({required this.themeData}) {
    // StorageManager.readData('brightness').then((value) {
    //   var themeMode = value ?? lightTheme;
    //   _themeData = themeMode == 'light' ? lightTheme : darkTheme;
    //   notifyListeners();
    // });
  }

  void setDarkMode() async {
    themeData = darkTheme;
    StorageManager.saveData('brightness', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    themeData = lightTheme;
    StorageManager.saveData('brightness', 'light');
    notifyListeners();
  }
}
