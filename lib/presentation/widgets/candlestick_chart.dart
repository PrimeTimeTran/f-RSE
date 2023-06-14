import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/data/models/all.dart';
import 'package:rse/presentation/widgets/all.dart';

class CandleStickChart extends StatelessWidget {
  final List<CandleStick> data;

  const CandleStickChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <CandleSeries<CandleStick, String>>[
              CandleSeries<CandleStick, String>(
                dataSource: data,
                xValueMapper: (CandleStick d, _) => d.date,
                lowValueMapper: (CandleStick d, _) => d.low,
                highValueMapper: (CandleStick d, _) => d.high,
                openValueMapper: (CandleStick d, _) => d.open,
                closeValueMapper: (CandleStick d, _) => d.close,
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
          PeriodSelector(
            periods: const ['live', '1d', '1w', '1m', '3m', '1y', 'all'],
          ),
        ],
      ),
    );
  }
}
