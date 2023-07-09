import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:rse/all.dart';

part 'chart.freezed.dart';

@freezed
class Chart with _$Chart {
  factory Chart({
    required String time,
    required String sym,
    required double xOffSet,
    required String type,
    required double startValue,
    required double latestValue,
    required String period,
    required double focusedValue,
    required List<CandleStick> candleSeries,
    required CandleStick candle,
    required List<DataPoint> data,
  }) = _Chart;

  factory Chart.defaultChart() => Chart(
    time: '',
    sym: '',
    xOffSet: 0,
    type: '',
    startValue: 0,
    latestValue: 0,
    period: '',
    focusedValue: 0,
    candleSeries: [],
    candle: CandleStick.defaultCandleStick(),
    data: [DataPoint.defaultDataPoint()],
  );
}
