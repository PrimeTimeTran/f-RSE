import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:rse/all.dart';

part 'asset.freezed.dart';

@freezed
class Asset with _$Asset {
  factory Asset({
    String? name,
    required double o,
    required Meta meta,
    required String sym,
    required Company company,
    required List<CandleStick> current,
  }) = _Asset;

  factory Asset.fromJson(Map<String, dynamic> json) {
    final metaJson = json['meta'] as String;
    final metaMap = jsonDecode(metaJson) as Map<String, dynamic>;
    final currentSeriesJson =
        jsonDecode(json['current'])['series'] as List<dynamic>;
    final currentSeries =
        currentSeriesJson.map((item) => CandleStick.fromJson(item)).toList();

    return Asset(
      o: 0.0,
      sym: json['sym'],
      name: json['name'],
      current: currentSeries,
      meta: Meta.fromJson(metaMap),
      company: Company.fromJson(json['company']),
    );
  }

  factory Asset.defaultAsset() => Asset(
        o: 0,
        sym: '',
        name: null,
        current: [],
        meta: Meta.defaultMeta(),
        company: Company.defaultCompany(),
      );
}
