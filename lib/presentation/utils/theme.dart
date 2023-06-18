import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: Colors.red,
    indicatorColor: Colors.white,
  ),
  primarySwatch: Colors.green,
  highlightColor: Colors.green[900],
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
);