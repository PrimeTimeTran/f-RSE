import 'dart:math';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:rse/data/all.dart';

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

int randomInt(int to, int from) {
  Random random = Random();
  int randomNumber = random.nextInt(from - to + 1) + to;
  return randomNumber;
}

String formatMoney(value) {
  value = value.toString();
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

formatField(data, field) {
  switch (field) {
    case 'name':
      return data.name;
    case 'value' || 'totalValue':
      return formatMoney(data.getValue(field).toString());
    case 'quantity':
      return data.quantity.toString();
    default:
      return "${data.getValue(field)}%";
  }
}

String formatPercent(double value) {
  return '${(value * 100).toStringAsFixed(2)}%';
}

String calculatePercentageChange(double newValue, double oldValue) {
  double percentageChange = ((newValue - oldValue) / oldValue) * 100;
  String sign = (percentageChange >= 0) ? '+' : '-';
  double absoluteChange = percentageChange.abs();
  return '$sign ${absoluteChange.toStringAsFixed(2)} %';
}

String calculateValueChange(double newValue, double oldValue) {
  double valueChange = newValue - oldValue;
  String sign = (valueChange >= 0) ? '+' : '-';
  double absoluteChange = valueChange.abs();
  return '$sign ${formatMoney(absoluteChange.toStringAsFixed(2))}';
}

double getLowestVal(List<CandleStick> series) {
  return series.reduce((value, element) => value.low < element.low ? value : element).low;
}

double getHighestVal(List<CandleStick> series) {
  return series.reduce((value, element) => value.high > element.high ? value : element).high;
}

DateTime roundDownToNearest5Minutes(DateTime dateTime) {
  final minute = dateTime.minute;
  final roundedMinute = (minute ~/ 5) * 5;
  return DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, roundedMinute);
}

String chooseFormat(String period, d) {
  final map = {
    'live': 'h:mma',
    '1d': 'h:mma',
    '1w': 'h:mma MMMM d',
    '1m': 'h:mma MMMM d',
    '3m': 'M/d',
  };

  final dateFormat = map[period] ?? 'yMd';
  return DateFormat(dateFormat).format(roundDownToNearest5Minutes(DateTime.parse(d.time))).toString();
}

int calculateIntervals(period, data){
  final map = {
    'live': 5,
    '1d': data.length ~/ 24,
    '1w': 30,
    '1m': 30,
    '3m': 30,
    '1y': 12,
  };

  return map[period] ?? 0;
}


