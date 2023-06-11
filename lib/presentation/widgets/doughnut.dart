import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/presentation/utils/all.dart';
import 'package:rse/data/models/all.dart' as models;

class Doughnut extends StatelessWidget {
  final String field;
  final int hoveredRowIndex;
  final List<models.Investment> data;
  final ValueNotifier<int> hoveredCellIndex;
  Doughnut({
    Key? key,
    required this.data,
    required this.field,
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
        legend: Legend(isVisible: true),
        series: <CircularSeries>[
          DoughnutSeries<models.Investment, String>(
            strokeWidth: 1,
            dataSource: data,
            enableTooltip: true,
            strokeColor: Colors.white,
            xValueMapper: (models.Investment data, _) => data.name,
            yValueMapper: (models.Investment data, _) =>
              field == 'name' ? data.percentage : data.getValue(field),
            dataLabelMapper: (models.Investment data, _) =>
              field == 'name' ? data.name
                  : (field == 'value' || field == 'totalValue')
                  ? formatMoney(data.getValue(field).toString())
                  : field == 'quantity' ? data.quantity.toString() : data.getValue(field).toString(),
            dataLabelSettings: DataLabelSettings(
              // Renders the data label
                isVisible: true
            ),
            pointColorMapper: (models.Investment data, _) {
              if (hoveredRowIndex != -1 && hoveredRowIndex == data.idx) {
                return Colors.lightGreenAccent;
              }
              if (hoveredCellIndex.value != -1 && hoveredCellIndex.value == data.idx) {
                return Colors.blue;
              }
              return segmentColors[data.idx % segmentColors.length];
            },
          ),
        ],
      ),
    );
  }

}