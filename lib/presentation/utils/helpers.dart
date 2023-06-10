import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<dynamic> loadJsonFile(String path) async {
  try {
    String content = await rootBundle.loadString(path);
    return json.decode(content);
  } catch (e) {
    if (kDebugMode) {
      debugPrint('Error loading JSON file: $e');
    }
  }
  return null;
}

void printResponse(http.Response response) {
  final responseMap = json.decode(response.body) as Map<String, dynamic>;
  responseMap.forEach((key, value) {
    if (kDebugMode) {
      debugPrint('$key: $value');
    }
  });
}

String formatMoney(String value) {
  final numberFormat = NumberFormat.currency(symbol: '\$');
  final moneyValue = double.parse(value.replaceAll(',', ''));
  return numberFormat.format(moneyValue);
}

String shortenMoney(String value) {
  final numberFormat = NumberFormat.currency(symbol: '\$');
  final moneyValue = double.parse(value.replaceAll(',', ''));

  if (moneyValue >= 1e9) {
    final shortenedValue = moneyValue / 1e9;
    return '${numberFormat.format(shortenedValue)} B';
  } else if (moneyValue >= 1e6) {
    final shortenedValue = moneyValue / 1e6;
    return '${numberFormat.format(shortenedValue)} M';
  } else if (moneyValue >= 1e3) {
    final shortenedValue = moneyValue / 1e3;
    return '${numberFormat.format(shortenedValue)} K';
  }

  return numberFormat.format(moneyValue);
}

String formatUtcToDM(DateTime utcTime) {
  final localTime = utcTime.toLocal();
  final day = localTime.day;
  final month = localTime.month;
  final formattedDate = '$day/$month';
  return formattedDate;
}