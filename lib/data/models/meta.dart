import 'package:freezed_annotation/freezed_annotation.dart';

part 'meta.freezed.dart';
part 'meta.g.dart';

@freezed
class Meta with _$Meta {
  const factory Meta({
    required double o,
    required double h,
    required double l,
    required double c,
    required double v,
    required double mc,
    required double dy,
    required double pe,
    required double av,
    required double awv,
    required double hiDay,
    required double loDay,
    required double hiYear,
    required double loYear,
  }) = _Meta;

  factory Meta.fromJson(Map<String, Object?> json) => _$MetaFromJson(json);

  factory Meta.defaultMeta() => const Meta(
    o: 0.0,
    h: 0.0,
    l: 0.0,
    c: 0.0,
    v: 0.0,
    mc: 0.0,
    dy: 0.0,
    pe: 0.0,
    av: 0.0,
    awv: 0.0,
    hiDay: 0.0,
    loDay: 0.0,
    hiYear: 0.0,
    loYear: 0.0,
  );
}
