import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:rse/all.dart';

Future<dynamic> loadJsonFile(String path) async {
  try {
    // String jsonContent = await rootBundle.loadString(path);
    final ByteData data = await rootBundle.load(path);
    String jsonContent = utf8.decode(data.buffer.asUint8List());
    return json.decode(jsonContent);
  } catch (e) {
    if (kDebugMode) {
      debugPrint('Error loading JSON file: $e');
    }
  }
  return null;
}

void printResponse(http.Response response) {
  final responseMap = json.decode(response.body) as Map<String, dynamic>;
  responseMap.forEach((key, v) {
    if (kDebugMode) {
      debugPrint('$key: $v');
    }
  });
}

int randomInt(int to, int from) {
  Random random = Random();
  int randomNumber = random.nextInt(from - to + 1) + to;
  return randomNumber;
}

String calculatePercentageChange(double newVal, double oldVal) {
  double gainLoss = getChangePercent(newVal, oldVal);
  String formatted = formatPercentage(gainLoss);
  return formatted;
}

double getChangePercent(double newVal, double oldVal) {
  return ((newVal - oldVal) / oldVal) * 100;
}

double getLowestVal(List<CandleStick> series) {
  return series.reduce((v, e) => v.low < e.low ? v : e).low;
}

double getHighestVal(List<CandleStick> series) {
  return series.reduce((v, e) => v.high > e.high ? v : e).high;
}

DateTime roundDownToNearest5Minutes(DateTime dt) {
  final minute = dt.minute;
  final roundedMinute = (minute ~/ 5) * 5;
  return DateTime(dt.year, dt.month, dt.day, dt.hour, roundedMinute);
}

DateTime roundToNearestHour(DateTime dt) {
  final minutes = dt.minute;
  final roundedMinutes = (minutes >= 30) ? 0 : 30;
  return DateTime(dt.year, dt.month, dt.day, dt.hour)
      .add(Duration(minutes: roundedMinutes));
}

int calculateIntervals(period, data){
  final map = {
    'live': 5,
    '1d': data.length ~/ 24,
    '1w': 30,
    '1m': 30,
    '3m': 30,
    'ytd': 12,
    '1y': 12,
  };

  return map[period] ?? 0;
}


