import 'package:flutter/material.dart';
import 'package:weather_app/utils/storage_manager.dart';

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData.dark();
  final lightTheme = ThemeData.light();

  ThemeData _themeData = ThemeData.dark();
  ThemeData get getTheme => _themeData;

  ThemeNotifier() {
    StorageManager.readData('brightness').then((value) {
      var themeMode = value ?? lightTheme;
      _themeData = themeMode == 'light' ? lightTheme : darkTheme;
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('brightness', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('brightness', 'light');
    notifyListeners();
  }
}
