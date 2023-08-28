import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  AppThemeData _themeData;

  ThemeProvider(AppThemeData themeData) : _themeData = themeData;

  AppThemeData get themeData => _themeData;

  set themeData(AppThemeData value) {
    _themeData = value;
    notifyListeners();
  }
}

class AppThemeData {
  final ThemeData theme;
  final ThemeData darkTheme;

  AppThemeData(this.theme, this.darkTheme);
}
