import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

const bool isWeb = kIsWeb;

bool isMed(BuildContext context) {
  return MediaQuery.of(context).size.width >= 768;
}

bool isSmall(BuildContext context) {
  return MediaQuery.of(context).size.width < 768;
}