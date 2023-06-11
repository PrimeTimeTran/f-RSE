import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/data/models/all.dart' as models;

class Doughnut extends StatelessWidget {
  final int hoveredRowIndex;
  final List<models.Investment> data;
  final ValueNotifier<int> hoveredCellIndex;
  Doughnut({
    Key? key,
    required this.data,
    required this.hoveredRowIndex,
    required this.hoveredCellIndex,
  }) : super(key: key);

  final List<Color> segmentColors = [
    Colors.blue[200]!,
    Colors.blue[400]!,
    Colors.blue[600]!,
    Colors.blue[800]!,
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SfCircularChart(
        series: <CircularSeries>[
          DoughnutSeries<models.Investment, String>(
            strokeWidth: 1,
            dataSource: data,
            enableTooltip: true,
            strokeColor: Colors.white, // Border color for all segments
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            xValueMapper: (models.Investment data, _) => data.name,
            yValueMapper: (models.Investment data, _) => data.percentage,
            pointColorMapper: (models.Investment data, _) {
              if (hoveredRowIndex != -1 && hoveredRowIndex == data.idx) {
                return Colors.green;
              }
              if (hoveredCellIndex.value != -1 && hoveredCellIndex.value == data.idx) {
                return Colors.blue; // Apply a different color for the hovered cell
              }
              return segmentColors[data.idx % segmentColors.length];
            },
          ),
        ],
      ),
    );
  }

}