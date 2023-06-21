import 'dart:ui';
import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Colors.white,
    surfaceTintColor: Colors.white,
  ),
  navigationBarTheme: const NavigationBarThemeData(
    indicatorColor: Colors.white,
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.green,
    primaryContainer: Colors.lightGreenAccent,
    secondary: Colors.green.shade900,
    inversePrimary: Colors.black,
    onPrimaryContainer: Colors.white,
    background: Colors.green,
    outline: Colors.black26,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.green,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  indicatorColor: Colors.white,
  navigationBarTheme: const NavigationBarThemeData(
    indicatorColor: Colors.green,
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.green,
    inversePrimary: Colors.white,
    background: Colors.grey[900]!,
    secondary: Colors.lightGreenAccent,
    primaryContainer: Colors.lightGreenAccent,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900]!,
  ),
);

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
    case 'background':
      return colorScheme.background;
    case 'outline':
      return colorScheme.outline;
    case 'secondary':
      return colorScheme.secondary;
    case 'surface':
      return colorScheme.surface;
    case 'inversePrimary':
      return colorScheme.inversePrimary;
    case 'onPrimaryContainer':
      return colorScheme.onPrimaryContainer;
    default:
      throw Exception('Invalid color key: $key');
  }
}