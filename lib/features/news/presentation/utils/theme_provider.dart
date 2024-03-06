import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme => _isDarkMode
      ? ThemeData(brightness: Brightness.dark, colorSchemeSeed: Colors.yellow)
      : ThemeData(brightness: Brightness.light, colorSchemeSeed: Colors.green);

  void changeTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
