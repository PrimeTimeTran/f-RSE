import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:rse/all.dart';

AppBar buildDevOptions(BuildContext context) {
  return AppBar(
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      },
    ),
    title: Consumer<ThemeModel>(
      builder: (context, themeModel, _) {
        return GestureDetector(
          onDoubleTap: themeModel.toggleTheme,
          onLongPressStart: (details) {
            _handleLongPress(details, context);
          },
          child: const Text('Royal Stock Exchange'),
        );
      },
    ),
  );
}

Future<String> getVersionId() async {
  try {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    return '$version $buildNumber';
  } on Exception catch (_) {
    return '';
  }
}

void _showModal(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  bool showAppConfig = remoteConfig.getValue('app_show_config').asBool();
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Column(
        children: [
          Text('Screen Width: ${width.toStringAsFixed(2)}'),
          Text('Screen Height: ${height.toStringAsFixed(2)}'),
          TextButton(
            onPressed: () => throw Exception(),
            child: const Text("Throw Test Exception"),
          ),
          TextButton(
            onPressed: () {
              final bool value = debugPaintSizeEnabled;
              debugPaintSizeEnabled = !value;
            },
            child: const Text("Enable Debug Paint Size"),
          ),
          if (showAppConfig)
            FutureBuilder<String>(
              future: getVersionId(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text(snapshot.data ?? '');
                }
              },
            ),
          FutureBuilder<String>(
            future: getVersionId(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text(
                    remoteConfig.getValue('app_secret').asString() ?? '');
              }
            },
          ),
        ],
      );
    },
  );
}

void _handleLongPress(LongPressStartDetails details, context) {
  _showModal(context);
}
