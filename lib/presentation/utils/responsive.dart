import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

const bool isWeb = kIsWeb;

bool isS(BuildContext context) {
  return MediaQuery.of(context).size.width <= 391;
}

bool isM(BuildContext context) {
  return MediaQuery.of(context).size.width <= 820;
}

bool isL(BuildContext context) {
  return MediaQuery.of(context).size.width >= 992;
}