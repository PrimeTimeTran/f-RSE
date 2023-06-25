import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/all.dart';

class Doughnut extends StatefulWidget {
  final String field;
  final int explodeIdx;
  final bool shouldExplode;
  final int hoveredRowIndex;
  final List<Investment> data;
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
    final String field = widget.data[widget.explodeIdx].totalValue.toString();
    //get theme
    final bool dark = isDarkMode(context);

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
              DoughnutSeries<Investment, String>(
                strokeWidth: 1,
                enableTooltip: true,
                dataSource: widget.data,
                strokeColor: Colors.white,
                xValueMapper: (Investment data, _) => data.name,
                dataLabelMapper: (Investment data, _) => formatField(data, widget.field),
                yValueMapper: (Investment data, _) => widget.field == 'name' ? data.percentage : data.getValue(widget.field),
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  color: dark ? Colors.black12 : Colors.white70,
                ),
                pointColorMapper: (Investment data, _) {
                  if (widget.hoveredRowIndex != -1 && widget.hoveredRowIndex == data.idx) {
                    return T(context, 'primary');
                  }
                  return Colors.green[200];
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
