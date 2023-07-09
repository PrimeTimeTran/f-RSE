import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/all.dart';

class PlaceholderCandleStickChart extends StatelessWidget {
  final double low;
  final double high;
  const PlaceholderCandleStickChart({super.key, required this.low, required this.high});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(
        isVisible: false,
        labelStyle: const TextStyle(color: Colors.transparent),
        labelIntersectAction: AxisLabelIntersectAction.none,
      ),
      series: <CandleSeries<CandleStick, String>>[
        CandleSeries<CandleStick, String>(
            dataSource: const [],
            lowValueMapper: (CandleStick d, _) => low,
            highValueMapper: (CandleStick d, _) => high,
            openValueMapper: (CandleStick d, _) => d.o,
            closeValueMapper: (CandleStick d, _) => d.c,
            xValueMapper: (CandleStick d, int index) => index.toString()
        ),
      ],
    );
  }
}