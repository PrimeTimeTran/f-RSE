import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/all.dart';

class LineChart extends StatefulWidget {
  const LineChart({super.key});

  @override
  LineChartState createState() => LineChartState();
}

class LineChartState extends State<LineChart> {
  double? tappedXPosition;
  double? draggedXPosition;
  late TrackballBehavior _trackballBehavior;

  @override
  Widget build(BuildContext context) {
    _setupTheme(context);

    return BlocBuilder<PortfolioCubit, PortfolioState>(
      builder: (context, state) {
        if (state is PortfolioLoading) {
          return const CircularProgressIndicator();
        } else if (state is PortfolioLoaded) {
          final bloc = context.read<PortfolioCubit>();
          context.read<ChartCubit>().chartPortfolio(bloc);
          return loadedChart();
        } else {
          return const SizedBox();
        }
      },
    );
  }

  loadedChart() {
    return BlocBuilder<ChartCubit, ChartState>(
      builder: (context, state) {
        if (state is UpdatedChart) {
          return chart(state.chart.data);
        } else if (state is HoveringChart) {
          return chart(state.chart.data);
        }
        return const SizedBox();
      }
    );
  }

  chart(data) {
    return SingleChildScrollView(
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
                  context.read<ChartCubit>().hoveredChart(item, null, offset!);
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
    );
  }

  _setupTheme(BuildContext context) {
    final color = T(context, 'inversePrimary');
    _trackballBehavior = TrackballBehavior(
      enable: true,
      lineWidth: 1,
      lineColor: color,
      shouldAlwaysShow: true,
      lineDashArray: const [5, 5],
      lineType: TrackballLineType.vertical,
      tooltipAlignment: ChartAlignment.near,
      activationMode: ActivationMode.singleTap,
    );
  }
}
