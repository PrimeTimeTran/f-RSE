import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/data/models/candlestick_data.dart';

class CandlestickChartExample extends StatelessWidget {
  final List<CandleStickData> stockData;

  CandlestickChartExample({required this.stockData});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <CandleSeries<CandleStickData, String>>[
          CandleSeries<CandleStickData, String>(
            dataSource: stockData,
            xValueMapper: (CandleStickData data, _) => data.date,
            lowValueMapper: (CandleStickData data, _) => data.low,
            highValueMapper: (CandleStickData data, _) => data.high,
            openValueMapper: (CandleStickData data, _) => data.open,
            closeValueMapper: (CandleStickData data, _) => data.close,
          ),
        ],
        trackballBehavior: TrackballBehavior(
          enable: true,
          lineWidth: 2,
          lineColor: Colors.blue,
          activationMode: ActivationMode.singleTap,
          tooltipSettings: InteractiveTooltip(
            enable: true,
            borderWidth: 1,
            color: Colors.grey[900]!,
            borderColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}
