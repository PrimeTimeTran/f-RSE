import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:rse/all.dart';

setup() async {
  if (kDebugMode) p('Setup...');
  setupEnvironments();
  await setupFirebase();
}

void setupEnvironments() async {
  if (kIsWeb && kReleaseMode) return;
  try {
    await dotenv.load(fileName: "assets/.env");
    debugPrint('Env loaded? ${dotenv.env['ENV_LOADED']}');
    setupAPI();
  } catch (e) {
    debugPrint('Error: dotenv $e');
  }
}