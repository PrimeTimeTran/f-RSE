import 'dart:convert';
import 'package:rse/data/models/all.dart';

class Asset {
  final String? name;
  final String? sym;
  final List<CandleStick> current;
  Asset({
    required this.name,
    required this.sym,
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
    return Asset(
      name: j['name'],
      sym: j['sym'],
      current: [
        for (var cs in jsonDecode(j[mapping[period]])['series']) CandleStick.fromJson(cs)
      ],
    );
  }
  factory Asset.defaultAsset() => Asset(
    sym: '',
    name: '',
    current: [],
  );
}