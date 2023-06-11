import 'package:flutter/material.dart';
import 'package:rse/presentation/utils/helpers.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/data/models/all.dart' as models;

class Dougnut extends StatefulWidget {
  final List<models.Investment> data;

  const Dougnut({super.key, required this.data});

  @override
  State<Dougnut> createState() => _DougnutState();
}

class _DougnutState extends State<Dougnut> with SingleTickerProviderStateMixin {
  late List<models.Investment> _chartData;
  late AnimationController _animationController;
  late int _animationDuration;

  @override
  void initState() {
    _chartData = widget.data;
    _animationDuration = randomInt(500, 1500);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _animationDuration),
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final List<Color> sliceColors = [
    Colors.blue,
    Colors.green,
    Colors.yellow,
  ];

  @override
  Widget build(BuildContext context) {
    print('Animation duration: $_animationDuration');

    return Expanded(
      flex: 1,
      child: SfCircularChart(
        series: <CircularSeries>[
          DoughnutSeries<models.Investment, String>(
            enableTooltip: true,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            xValueMapper: (models.Investment data, _) => data.name,
            yValueMapper: (models.Investment data, _) => data.percentage,
            onPointTap: (ChartPointDetails details) {
              print(details.pointIndex);
            },
            dataSource: widget.data,
            animationDuration: _animationDuration.toDouble(), // Apply the specific animation duration to the series
            // pointColorMapper: (models.Investment data, _) =>
            // sliceColors[widget.data],
          ),
        ],
      ),
    );
  }
}
