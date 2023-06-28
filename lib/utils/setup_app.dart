import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'api.dart';
import 'firebase.dart';

void setupAPP() {
  setupEnvironments();
  setupFirebase();
}

void setupEnvironments() async {
  try {
    await dotenv.load(fileName: "assets/.env");
    debugPrint('Env loaded? ${dotenv.env['ENV_LOADED']}');
    setupAPI();
  } catch (e) {
    debugPrint('Error: dotenv $e');
  }
}