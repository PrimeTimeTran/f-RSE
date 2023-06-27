import 'dart:convert';

import 'package:rse/data/models/all.dart';

class Asset {
  final double o;
  final double v;
  final double dy;
  final double pe;
  final double av;
  final double mc;
  final String sym;
  final double hiDay;
  final String? name;
  final double value;
  final double loDay;
  final double hiYear;
  final double loYear;
  final Company company;
  final List<CandleStick> current;
  Asset({
    required this.o,
    required this.v,
    required this.dy,
    required this.av,
    required this.mc,
    required this.pe,
    required this.sym,
    required this.name,
    required this.value,
    required this.hiDay,
    required this.loDay,
    required this.hiYear,
    required this.loYear,
    required this.current,
    required this.company,
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
      mc: j['mc'],
      pe: j['pe'],
      sym: j['sym'],
      v: j['v'] ?? 0,
      name: j['name'],
      current: series,
      av: j['av'] ?? 0,
      hiDay: j['hiDay'],
      dy: j['dy'] ?? 0,
      loDay: j['loDay'],
      hiYear: j['hiYear'],
      loYear: j['loYear'],
      value: series.first.close,
      company: Company.fromJSON(j['company']),
    );
  }
  factory Asset.defaultAsset() => Asset(
    o: 0,
    v: 0,
    av: 0,
    pe: 0,
    mc: 0,
    dy: 0,
    sym: '',
    name: '',
    value: 0,
    hiDay: 0,
    loDay: 0,
    hiYear: 0,
    loYear: 0,
    current: [CandleStick.fact()],
    company: Company.defaultCompany(),
  );

  Asset copyWith({
    double? o,
    double? v,
    double? av,
    double? pe,
    double? dy,
    double? mc,
    String? sym,
    String? name,
    double? loDay,
    double? value,
    double? hiDay,
    double? loYear,
    double? hiYear,
    Company? company,
    List<CandleStick>? current,
  }) {
    return Asset(
      o: o ?? this.o,
      v: v ?? this.v,
      dy: dy ?? this.dy,
      pe: pe ?? this.pe,
      av: av ?? this.av,
      mc: mc ?? this.mc,
      sym: sym ?? this.sym,
      name: name ?? this.name,
      hiDay: hiDay ?? this.hiDay,
      value: value ?? this.value,
      loDay: loDay ?? this.loDay,
      hiYear: hiYear ?? this.hiYear,
      loYear: loYear ?? this.loYear,
      current: current ?? this.current,
      company: company ?? this.company,
    );
  }
}
