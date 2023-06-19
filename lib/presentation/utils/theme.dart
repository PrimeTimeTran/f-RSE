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
    inversePrimary: Colors.white,
    onPrimaryContainer: Colors.white,
    background: Colors.green,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.green,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  indicatorColor: Colors.white,
  navigationBarTheme: const NavigationBarThemeData(
    indicatorColor: Colors.white,
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.green,
    primaryContainer: Colors.lightGreenAccent,
    inversePrimary: Colors.white,
    secondary: Colors.lightGreenAccent,
    background: Colors.grey[900]!,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900]!,
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
    default:
      throw Exception('Invalid color key: $key');
  }
}