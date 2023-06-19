import 'dart:convert';

import 'package:rse/data/models/all.dart';

class Asset {
  final double o;
  final String sym;
  final String? name;
  final double value;
  final List<CandleStick> current;
  Asset({
    required this.o,
    required this.value,
    required this.sym,
    required this.name,
    required this.current,
  });
  factory Asset.fromJson(Map<String, dynamic> j , String period) {
    Map<String, dynamic> mapping = {
      "live": "live",
      "1d": "oneDay",
      "1w": "oneWeek",
      "1m": "oneMonth",
      "3m": "threeMonths",
      "ytd": "yearToDate",
      "1y": "oneYear",
      "all": "allData",
    };
    var series = [for (var cs in jsonDecode(j[mapping[period]])['series']) CandleStick.fromJson(cs)];
    return Asset(
      o: j['o'],
      sym: j['sym'],
      name: j['name'],
      current: series,
      value: series[series.length - 1].close,
    );
  }
  factory Asset.defaultAsset() => Asset(
    o: 0,
    sym: '',
    name: '',
    value: 0,
    current: [],
  );
}