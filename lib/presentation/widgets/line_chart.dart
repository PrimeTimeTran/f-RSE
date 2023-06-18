import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/data/models/all.dart';
import 'package:rse/presentation/widgets/all.dart';

class LineChart extends StatefulWidget {
  final List<DataPoint> data;

  const LineChart({super.key, required this.data});

  @override
  LineChartState createState() => LineChartState();
}

class LineChartState extends State<LineChart> {
  String period = 'live';
  double? tappedXPosition;
  double? draggedXPosition;
  late List<DataPoint> data;
  final TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);
  final TrackballBehavior _trackballBehavior = TrackballBehavior(
    enable: true,
    lineWidth: 2,
    shouldAlwaysShow: true,
    lineColor: Colors.blue,
    activationMode: ActivationMode.singleTap,
    tooltipSettings: InteractiveTooltip(
      enable: true,
      borderWidth: 1,
      color: Colors.grey[900]!,
      borderColor: Colors.blue,
    ),
  );

  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: GestureDetector(
            onTapDown: (TapDownDetails details) {
              final RenderBox referenceBox =
                  context.findRenderObject() as RenderBox;
              final tappedPosition =
                  referenceBox.globalToLocal(details.globalPosition);
              setState(() {
                tappedXPosition = tappedPosition.dx;
              });
            },
            child: Stack(
              children: [
                KeyedSubtree(
                  key: UniqueKey(),
                  child: SfCartesianChart(
                    tooltipBehavior: _tooltipBehavior,
                    trackballBehavior: _trackballBehavior,
                    title: ChartTitle(text: 'Portfolio Value'),
                    primaryXAxis: DateTimeAxis(
                      isVisible: true,
                      labelRotation: 45,
                      dateFormat: DateFormat.Hm(),
                      intervalType: DateTimeIntervalType.hours,
                    ),
                    series: <LineSeries<DataPoint, DateTime>>[
                      LineSeries<DataPoint, DateTime>(
                        dataSource: data.take(50).toList(),
                        yValueMapper: (DataPoint d, _) => d.y,
                        xValueMapper: (DataPoint d, _) => DateTime.parse(d.x),
                      ),
                    ],
                  )
                ),
                if (tappedXPosition != null)
                  Positioned.fill(
                    left: tappedXPosition!,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 1,
                        color: Colors.red,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        PeriodSelector(),
      ],
    );
  }
}

