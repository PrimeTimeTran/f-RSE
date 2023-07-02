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
  TrackballBehavior? _trackballBehavior;

  @override
  void initState() {
    super.initState();
    _trackballBehavior = TrackballBehavior(
      enable: true,
      lineWidth: 1,
      shouldAlwaysShow: true,
      lineDashArray: const [5, 5],
      lineType: TrackballLineType.vertical,
      tooltipAlignment: ChartAlignment.near,
      activationMode: ActivationMode.singleTap,
      tooltipSettings: const InteractiveTooltip(enable: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        if (state is PortfolioLoadedSuccess) {
          final data = state.portfolio.series;
          return buildChart(data);
        } else {
          return const SizedBox();
        }
      },
      listener: (context, state) {
        if (state is PortfolioLoadedSuccess) {
          // BlocProvider.of<ChartBloc>(context).add(ChartUpdate(state.portfolio));

          // For making sure the header of the chart is loaded on initial load
          // Change if better solution is found.
          context.read<ChartBloc>().chartPortfolio(state.portfolio);
        }
      },
    );
  }

  Widget buildChart(List<DataPoint> data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ChartHeader(),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: isS(context) ? const EdgeInsets.all(0) : const EdgeInsets.only(left: 40, right: 40),
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  trackballBehavior: _trackballBehavior,
                  onTrackballPositionChanging: (TrackballArgs args) =>
                      _trackballChange(args, data),
                  primaryXAxis: CategoryAxis(
                    isVisible: false,
                  ),
                  series: <LineSeries<DataPoint, DateTime>>[
                    LineSeries<DataPoint, DateTime>(
                      color: Colors.green,
                      dataSource: data,
                      yValueMapper: (DataPoint d, _) => d.y,
                      xValueMapper: (DataPoint d, _) => DateTime.parse(d.x),
                    ),
                  ],
                  primaryYAxis: NumericAxis(
                    isVisible: false,
                    plotBands: [
                      PlotBand(
                        opacity: 0.5,
                        borderWidth: 1,
                        end: data.first.y,
                        start: data.first.y,
                        dashArray: const [1, 3],
                        borderColor: T(context, 'inversePrimary'),
                      ),
                    ],
                  ),
                ),
              ),
              const TimeLabel(),
            ],
          ),
          const PeriodSelector(),
        ],
      ),
    );
  }

  _trackballChange(TrackballArgs args, data) {
    final offset = args.chartPointInfo.xPosition;
    final point = args.chartPointInfo.chartDataPoint!.overallDataPointIndex;
    if (offset != null && point != null && data[point] != null) {
      final item = data[point];
      context.read<ChartBloc>().hoveredLineChart(item, offset);
    }
  }
}
