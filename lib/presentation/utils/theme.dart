// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  indicatorColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    titleTextStyle: TextStyle(fontSize: 20, color: Colors.black),
  ),
  colorScheme: const ColorScheme.light(
    outline: Colors.grey,
    primary: Colors.green,
    primaryContainer: Colors.white,
    onPrimaryContainer: Colors.white,
    inversePrimary: Colors.black,
    secondary: Color(0xFF227C9D),
    tertiary: Color(0xFF30BFBF),
    onError: Color(0xFFC62828),
    surface: Colors.white,
    secondaryContainer: Colors.white,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  indicatorColor: Colors.white,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(fontSize: 20, color: Colors.white),
  ),
  colorScheme: const ColorScheme.dark(
    outline: Colors.grey,
    primary: Colors.green,
    primaryContainer: Colors.black,
    onPrimaryContainer: Colors.black,
    inversePrimary: Colors.white,
    secondary: Color(0xFF227C9D),
    tertiary: Color(0xFF30BFBF),
    onError: Color(0xFFC62828),
    surface: Colors.black38,
    secondaryContainer: Colors.black38,
  ),
);

Color T(BuildContext context, String key) {
  final colorScheme = Theme.of(context).colorScheme;
  switch (key) {
    case 'primary':
      return colorScheme.primary;
    case 'primaryContainer':
      return colorScheme.primaryContainer;
    case 'secondary':
      return colorScheme.secondary;
    case 'surface':
      return colorScheme.surface;
    case 'inversePrimary':
      return colorScheme.inversePrimary;
    case 'onPrimaryContainer':
      return colorScheme.onPrimaryContainer;
    case 'outline':
      return colorScheme.outline;
    case 'tertiary':
    case 'background':
      return colorScheme.background;
    case 'secondaryContainer':
      return colorScheme.secondaryContainer;
    default:
      throw Exception('Invalid color key: $key');
  }
}

class ThemeModel with ChangeNotifier {
  bool _isDarkMode = window.platformBrightness == Brightness.dark;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  ThemeModel() {
    window.onPlatformBrightnessChanged = _handleBrightnessChange;
  }

  void _handleBrightnessChange() {
    _isDarkMode = window.platformBrightness == Brightness.dark;
    notifyListeners();
  }

  @override
  void dispose() {
    window.onPlatformBrightnessChanged = null;
    super.dispose();
  }
}

bool isDarkMode(BuildContext context) {
  final theme = Theme.of(context).brightness;
  return theme == Brightness.dark;
}
