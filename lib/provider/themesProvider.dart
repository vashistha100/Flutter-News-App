import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemesProvider with ChangeNotifier {
  // ThemeMode themeMode = ThemeMode.dark;

  // // bool get isDarkMode => themeMode == ThemeMode.dark;
  // bool isOn = true;

  // void toggleTheme() {
  //   themeMode == isOn ? ThemeMode.dark : ThemeMode.light;
  //   isOn = !isOn;
  //   notifyListeners();
  // }

  final String key = "theme";
  bool _darkTheme = false;
  

  bool get darkTheme => _darkTheme;

  // ThemeNotifier() {
  //   _darkTheme = true;
  // }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    notifyListeners();
  }
}

class MyThemes {
  static final lightTheme = ThemeData(scaffoldBackgroundColor: Colors.white);
  static final darkTheme =
      ThemeData(scaffoldBackgroundColor: Colors.grey.shade700);
}
