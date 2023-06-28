import 'dart:convert';

import 'package:rse/all.dart';

class Asset {
  final double o;
  final Meta meta;
  final String sym;
  final String? name;
  final Company company;
  final List<CandleStick> current;
  Asset({
    required this.o,
    required this.sym,
    required this.name,
    required this.meta,
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
    final series = [for (var cs in jsonDecode(j[mapping[period]])['series']) CandleStick.fromJson(cs)];
    final Meta meta = Meta.fromJSON(jsonDecode(j['meta']));
    meta.o = series.last.open;
    return Asset(
      o: meta.o,
      meta: meta,
      sym: j['sym'],
      name: j['name'],
      current: series,
      company: Company.fromJSON(j['company']),
    );
  }
  factory Asset.defaultAsset() => Asset(
    o: 0,
    sym: '',
    name: '',
    meta: Meta.defaultMeta(),
    current: [CandleStick.fact()],
    company: Company.defaultCompany(),
  );

  Asset copyWith({
    double? o,
    Meta? meta,
    String? sym,
    String? name,
    Company? company,
    List<CandleStick>? current,
  }) {
    return Asset(
      o: o ?? this.o,
      sym: sym ?? this.sym,
      name: name ?? this.name,
      meta: meta ?? this.meta,
      current: current ?? this.current,
      company: company ?? this.company,
    );
  }
}


class Meta {
  double o;
  final double h;
  final double l;
  final double c;
  final double v;
  final double awv;
  final double mc;
  final double dy;
  final double pe;
  final double av;
  final double hiDay;
  final double loDay;
  final double hiYear;
  final double loYear;

  Meta({
    required this.o,
    required this.h,
    required this.l,
    required this.c,
    required this.v,
    required this.mc,
    required this.dy,
    required this.pe,
    required this.av,
    required this.awv,
    required this.hiDay,
    required this.loDay,
    required this.hiYear,
    required this.loYear,
  });

  factory Meta.defaultMeta() => Meta(
    // add all fields needed
    o: 0,
    h: 0,
    l: 0,
    c: 0,
    v: 0,
    mc: 0,
    dy: 0,
    pe: 0,
    av: 0,
    awv: 0,
    hiDay: 0,
    loDay: 0,
    hiYear: 0,
    loYear: 0,

  );

  factory Meta.fromJSON(Map<String, dynamic> json) {
    return Meta(
      o: json['o'] ?? 0,
      h: json['h'] ?? 0,
      l: json['l'] ?? 0,
      c: json['c'] ?? 0,
      v: json['v'] ?? 0,
      mc: json['mc'] ?? 0,
      av: json['av'] ?? 0,
      dy: json['dy'] ?? 0,
      pe: json['pe'] ?? 0,
      awv: json['awv'] ?? 0,
      hiDay: json['hiDay'] ?? 0,
      loDay: json['loDay'] ?? 0,
      hiYear: json['hiYear'] ?? 0,
      loYear: json['loYear'] ?? 0,
    );
  }
}