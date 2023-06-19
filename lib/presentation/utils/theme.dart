import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  primarySwatch: Colors.green,
  primaryColor: Colors.green,
  brightness: Brightness.light,
  highlightColor: Colors.green[900],
  unselectedWidgetColor: Colors.grey,
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Colors.grey,
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: Colors.red,
    indicatorColor: Colors.white,
  ),
);

final darkTheme = ThemeData(
  primaryColor: Colors.green,
  highlightColor: Colors.green[900],
  brightness: Brightness.dark,
  indicatorColor: Colors.white,
  unselectedWidgetColor: Colors.white,
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Colors.white,
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: Colors.red,
    indicatorColor: Colors.white,
  ),
);

class ThemeModel with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

bool isDarkMode(BuildContext context) {
  final theme = Theme.of(context).brightness;
  return theme == Brightness.dark;
}