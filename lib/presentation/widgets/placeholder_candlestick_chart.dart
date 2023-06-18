import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/data/models/all.dart';

class PlaceholderCandleStickChart extends StatelessWidget {
  const PlaceholderCandleStickChart({super.key});

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
            dataSource: [],
            lowValueMapper: (CandleStick d, _) => d.low,
            highValueMapper: (CandleStick d, _) => d.high,
            openValueMapper: (CandleStick d, _) => d.open,
            closeValueMapper: (CandleStick d, _) => d.close,
            xValueMapper: (CandleStick d, int index) => index.toString()
        ),
      ],
    );
  }
}