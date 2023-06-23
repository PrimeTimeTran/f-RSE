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
  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      T(context, 'secondary'),
    ];
    final String field = widget.data[widget.explodeIdx].totalValue.toString();
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .7,
          child: SfCircularChart(
            legend: Legend(
                isVisible: true,
                offset: const Offset(0, 40),
                position: LegendPosition.top,
                alignment: ChartAlignment.center,
                overflowMode: LegendItemOverflowMode.wrap,
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
                  color: T(context, 'tertiary'),
                ),
                pointColorMapper: (models.Investment data, _) {
                  if (widget.hoveredRowIndex != -1 && widget.hoveredRowIndex == data.idx) {
                    return T(context, 'tertiary');
                  }
                  return colors[data.idx % colors.length];
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
