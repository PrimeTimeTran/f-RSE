import 'package:firebase_analytics/firebase_analytics.dart';

void event() async {
}

void logPeriodSelect(String name) async {
  await FirebaseAnalytics.instance.logEvent(
    name: "selected_period",
    parameters: {
      "name": name,
    },
  );
}
