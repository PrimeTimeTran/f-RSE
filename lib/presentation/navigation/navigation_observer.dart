import 'package:flutter/material.dart';

class MyNavigatorObserver extends NavigatorObserver {
  late Function onPushStack;
  bool isFirstRoute = true;

  MyNavigatorObserver({required this.onPushStack});

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);

    // Ignore the initial route
    if (!isFirstRoute) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        onPushStack(0);
      });
    }

    isFirstRoute = false;
  }
}
