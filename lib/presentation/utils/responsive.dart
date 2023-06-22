import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

const bool isWeb = kIsWeb;

bool isSmall(BuildContext context) {
  return MediaQuery.of(context).size.width < 768;
}

bool isMed(BuildContext context) {
  return MediaQuery.of(context).size.width >= 768;
}
