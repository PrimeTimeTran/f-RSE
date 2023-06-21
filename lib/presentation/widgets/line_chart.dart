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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ChartHeader(),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SfCartesianChart(
                        plotAreaBorderWidth: 0,
                        trackballBehavior: _trackballBehavior,
                        primaryYAxis: NumericAxis(
                            isVisible: false,
                            majorGridLines: const MajorGridLines(
                              width: 2,
                              dashArray: <double>[4, 3],
                            ),
                            plotBands: [
                              PlotBand(
                                opacity: 0.5,
                                borderWidth: 1,
                                end: data.last.y,
                                start: data.last.y,
                                dashArray: const [4, 3],
                                borderColor: T(context, 'inversePrimary'),
                              )
                            ]
                        ),
                        primaryXAxis: DateTimeAxis(
                          isVisible: false,
                          majorGridLines: const MajorGridLines(width: 0),
                        ),
                        onTrackballPositionChanging: (TrackballArgs args) {
                          final offset = args.chartPointInfo.xPosition;
                          final point = args.chartPointInfo.chartDataPoint!.overallDataPointIndex;
                          final item = data[point!];
                          context.read<ChartCubit>().setHoveredPoint(item, offset!);
                        },
                        series: <LineSeries<DataPoint, DateTime>>[
                          LineSeries<DataPoint, DateTime>(
                            color: Colors.green,
                            dataSource: data.take(50).toList(),
                            yValueMapper: (DataPoint d, _) => d.y,
                            xValueMapper: (DataPoint d, _) => DateTime.parse(d.x),
                          ),
                        ],
                      ),
                      const TimeLabel(),
                    ],
                  ),
                  const PeriodSelector()
                ],
              ),
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
    final color = T(context, 'inversePrimary');
    _trackballBehavior = TrackballBehavior(
      enable: true,
      lineWidth: 1,
      lineColor: color,
      lineDashArray: const [5, 5],
      lineType: TrackballLineType.vertical,
      tooltipAlignment: ChartAlignment.near,
      activationMode: ActivationMode.singleTap,
      tooltipSettings: const InteractiveTooltip(enable: false),
    );
  }
}
