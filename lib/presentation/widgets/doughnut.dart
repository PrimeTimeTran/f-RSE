import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/presentation/all.dart';
import 'package:rse/data/models/all.dart' as models;

class Doughnut extends StatefulWidget {
  final String field;
  final int explodeIdx;
  final bool shouldExplode;
  final int hoveredRowIndex;
  final List<models.Investment> data;
  final ActivationMode activationMode;

  const Doughnut({
    Key? key,
    required this.data,
    required this.field,
    required this.explodeIdx,
    required this.shouldExplode,
    required this.activationMode,
    required this.hoveredRowIndex,
  }) : super(key: key);

  @override
  DoughnutState createState() => DoughnutState();
}

class DoughnutState extends State<Doughnut> {
  final List<Color> colors = [
    Colors.grey[900]!,
  ];

  @override
  Widget build(BuildContext context) {
    const chartSizePercentage = 0.5;
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    final chartWidth = screenWidth * chartSizePercentage;
    final chartHeight = screenHeight * chartSizePercentage;
    final String field = widget.data[widget.explodeIdx].totalValue.toString();

    return Expanded(
      flex: 1,
      child: Column(
        children: [
          SizedBox(
            width: chartWidth,
            height: chartHeight,
            child: SfCircularChart(
              legend: Legend(
                  isVisible: true,
                  offset: const Offset(50, 40),
                  position: LegendPosition.left,
              ),
              annotations: <CircularChartAnnotation>[
                CircularChartAnnotation(
                  widget: Text(
                      field,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(216, 225, 227, 1),
                      )
                    ),
                )
              ],
              series: <CircularSeries>[
                DoughnutSeries<models.Investment, String>(
                  strokeWidth: 1,
                  enableTooltip: true,
                  dataSource: widget.data,
                  strokeColor: Colors.white,
                  xValueMapper: (models.Investment data, _) => data.name,
                  dataLabelMapper: (models.Investment data, _) => formatField(data, widget.field),
                  yValueMapper: (models.Investment data, _) => widget.field == 'name' ? data.percentage : data.getValue(widget.field),
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    color: T(context, 'inversePrimary'),
                  ),

                  pointColorMapper: (models.Investment data, _) {
                    if (widget.hoveredRowIndex != -1 && widget.hoveredRowIndex == data.idx) {
                      return T(context, 'primary');
                    }
                    return colors[data.idx % colors.length];
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
