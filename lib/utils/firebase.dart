import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'firebase_options.dart';

import 'package:rse/all.dart';

final remoteConfig = FirebaseRemoteConfig.instance;
late FirebaseAnalyticsObserver fbAnalyticsObserver;

setupFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    fbAnalyticsObserver = FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);

    await remoteConfig.fetchAndActivate();

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: kDebugMode ? 5 : 720),
      ),
    );

    // Crashlytics isn't supported on web.
    // https://github.com/firebase/flutterfire/issues/4631
    if (!kIsWeb) {
      remoteConfig.onConfigUpdated.listen((event) async {
        await remoteConfig.activate();
      });

      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
      p('Firebase initialized');
    }
  } catch (e) {
    debugPrint('Error: Firebase $e');
  }
}

void logPeriodSelect(String name) async {
  await FirebaseAnalytics.instance.logEvent(
    name: "selected_period",
    parameters: {
      "name": name,
    },
  );
}

void logAssetView(String name) async {
  await FirebaseAnalytics.instance.logEvent(
    name: "viewed_asset",
    parameters: {
      "name": name,
    },
  );
}

void logTradeAsset(String name) async {
  await FirebaseAnalytics.instance.logEvent(
    name: "choose_trade_asset",
    parameters: {
      "name": name,
    },
  );
}

void logTradeAssetOption(String name) async {
  await FirebaseAnalytics.instance.logEvent(
    name: "choose_trade_asset_option",
    parameters: {
      "name": name,
    },
  );
}

void setScreenName(String name) async {
  FirebaseAnalytics.instance.setCurrentScreen(screenName: name);
}

void logJsonLoadTime(String duration) async {
  String platform = kIsWeb ? "web" : Platform.operatingSystem;

  await FirebaseAnalytics.instance.logEvent(
    name: "load_time_json_file",
    parameters: {
      "platform": platform,
      "duration": duration,
      "env": kReleaseMode ? "release" : "debug",
    },
  );
}

void logAppLoadSuccess() async {
  String platform = kIsWeb ? "web" : Platform.operatingSystem;
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;
  await FirebaseAnalytics.instance.logEvent(
    name: "app_load_success",
    parameters: {
      "platform": platform,
      "device": '$version $buildNumber',
      "env": kReleaseMode ? "release" : "debug",
    },
  );
}