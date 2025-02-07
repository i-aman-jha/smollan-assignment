import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system; // Default to system theme

  void updateTheme(ThemeMode mode) {
    themeMode = mode;
    notifyListeners();
  }
}
