import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

void printResponse(http.Response response) {
  final responseMap = json.decode(response.body) as Map<String, dynamic>;
  responseMap.forEach((key, value) {
    print('$key: $value');
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