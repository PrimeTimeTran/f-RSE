import 'package:freezed_annotation/freezed_annotation.dart';

part 'candlestick.freezed.dart';
part 'candlestick.g.dart';

@freezed
class CandleStick with _$CandleStick {
  factory CandleStick({
    required double l,
    required double o,
    required double h,
    required double c,
    required String time,
  }) = _CandleStick;

  factory CandleStick.fromJson(Map<String, dynamic> j) =>
      _$CandleStickFromJson(j);

  factory CandleStick.defaultCandleStick() => CandleStick(
    l: 0,
    o: 0,
    h: 0,
    c: 0,
    time: '',
  );
}