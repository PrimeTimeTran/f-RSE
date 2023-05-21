import 'dart:io';
import 'package:flutter/material.dart';

import 'package:rse/widgets/drawer.dart';
import 'package:rse/widgets/bottom_tab.dart';

import 'package:rse/utils/constants.dart' as constants;

void main() {
  runApp(MyApp());
  HttpOverrides.global = MyHttpOverrides();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  void changeTabIndex(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('RSE'),
        ),
        drawer: Drawerr(),
        body: constants.TABS[_currentIndex],
        bottomNavigationBar:
            BottomTab(change: changeTabIndex, index: _currentIndex),
      ),
    );
  }
}
