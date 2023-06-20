import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/all.dart';
import 'package:rse/presentation/all.dart';

class LineChart extends StatefulWidget {
  const LineChart({super.key});

  @override
  LineChartState createState() => LineChartState();
}

class LineChartState extends State<LineChart> {
  double? tappedXPosition;
  double? draggedXPosition;
  late List<DataPoint> data;
  late TrackballBehavior _trackballBehavior;

  @override
  Widget build(BuildContext context) {
    _setupTheme(context);

    return BlocBuilder<PortfolioCubit, PortfolioState>(
      builder: (context, state) {
        if (state is PortfolioLoading) {
          return const CircularProgressIndicator();
        } else if (state is PortfolioLoaded) {
          final data = context.read<PortfolioCubit>().dataPoints;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .8,
                  height: MediaQuery.of(context).size.height * .4,
                  child: SfCartesianChart(
                    borderWidth: 0,
                    plotAreaBorderWidth: 0,
                    borderColor: Colors.transparent,
                    trackballBehavior: _trackballBehavior,
                    primaryYAxis: NumericAxis(majorGridLines: const MajorGridLines(width: 0)),
                    primaryXAxis: DateTimeAxis(
                      isVisible: true,
                      labelRotation: 45,
                      dateFormat: DateFormat.Hm(),
                      majorGridLines: const MajorGridLines(width: 0)
                    ),
                    series: <LineSeries<DataPoint, DateTime>>[
                      LineSeries<DataPoint, DateTime>(
                        dataSource: data.take(50).toList(),
                        yValueMapper: (DataPoint d, _) => d.y,
                        xValueMapper: (DataPoint d, _) => DateTime.parse(d.x),
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
                const PeriodSelector(),
              ],
            ),
          );
        } else if (state is PortfolioError) {
          return Text('Error: ${state.errorMessage}');
        } else {
          return const Text('Unknown state');
        }
      },
    );
  }

  _setupTheme(BuildContext context) {
    final color = T(context, 'primary');
    _trackballBehavior = TrackballBehavior(
      enable: true,
      lineWidth: 1,
      lineColor: color,
      lineType: TrackballLineType.vertical,
      tooltipAlignment: ChartAlignment.near,
      activationMode: ActivationMode.singleTap,
      tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
      tooltipSettings: const InteractiveTooltip(
        enable: true,
        borderWidth: 5,
        color: Colors.red,
        canShowMarker: true,
        borderColor: Colors.green,
        format: 'point.x : point.y',
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 13,
        ),
      ),
    );
  }
}

