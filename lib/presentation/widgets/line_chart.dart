import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/data/models/all.dart';

class LineChart extends StatefulWidget {
  final List<DataPoint> data;

  LineChart({required this.data});

  @override
  _LineChartState createState() => _LineChartState(data: data);
}

class _LineChartState extends State<LineChart> {
  late List<DataPoint> data;
  double? tappedXPosition;

  _LineChartState({required this.data});

  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        final RenderBox referenceBox = context.findRenderObject() as RenderBox;
        final tappedPosition = referenceBox.globalToLocal(details.globalPosition);
        setState(() {
          tappedXPosition = tappedPosition.dx;
        });
      },
      child: Stack(
        children: [
          SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <LineSeries<DataPoint, String>>[
              LineSeries<DataPoint, String>(
                dataSource: data,
                xValueMapper: (DataPoint d, _) => d.x,
                yValueMapper: (DataPoint d, _) => d.y,
              ),
            ],
            trackballBehavior: TrackballBehavior(
              enable: true,
              tooltipSettings: InteractiveTooltip(
                enable: true,
                borderWidth: 1,
                color: Colors.grey[900]!,
                borderColor: Colors.blue,
              ),
              lineColor: Colors.blue,
              lineWidth: 2,
              activationMode: ActivationMode.singleTap,
            ),
          ),
          if (tappedXPosition != null)
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 1,
                  color: Colors.red,
                ),
              ),
              left: tappedXPosition!,
            ),
        ],
      ),
    );
  }
}