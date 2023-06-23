import 'dart:io' show Platform;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:device_info_plus/device_info_plus.dart';

void event() async {
  String os = Platform.operatingSystem;
  await FirebaseAnalytics.instance.logEvent(
    name: "success_app_load",
    parameters: {
      "os": os,
    },
  );
}

void logPeriodSelect(String name) async {
  await FirebaseAnalytics.instance.logEvent(
    name: "selected_period",
    parameters: {
      "name": name,
    },
  );
}
