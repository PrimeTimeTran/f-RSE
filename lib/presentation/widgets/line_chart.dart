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
  String period = 'live';
  double? tappedXPosition;
  double? draggedXPosition;
  late List<DataPoint> data;
  late TrackballBehavior _trackballBehavior;
  final TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);

  @override
  Widget build(BuildContext context) {
    _setupTheme(context);

    return BlocConsumer<PortfolioCubit, PortfolioState>(
      builder: (context, state) {
        if (state is PortfolioLoading) {
          return const CircularProgressIndicator();
        } else if (state is PortfolioLoaded) {
          final data = context.read<PortfolioCubit>().dataPoints;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    final RenderBox referenceBox =
                    context.findRenderObject() as RenderBox;
                    final tappedPosition =
                    referenceBox.globalToLocal(details.globalPosition);
                    setState(() {
                      tappedXPosition = tappedPosition.dx;
                    });
                  },
                  child: Stack(
                    children: [
                      KeyedSubtree(
                          key: UniqueKey(),
                          child: SfCartesianChart(
                            tooltipBehavior: _tooltipBehavior,
                            trackballBehavior: _trackballBehavior,
                            title: ChartTitle(text: 'Portfolio Value'),
                            primaryXAxis: DateTimeAxis(
                              isVisible: true,
                              labelRotation: 45,
                              dateFormat: DateFormat.Hm(),
                              intervalType: DateTimeIntervalType.hours,
                            ),
                            series: <LineSeries<DataPoint, DateTime>>[
                              LineSeries<DataPoint, DateTime>(
                                dataSource: data.take(50).toList(),
                                yValueMapper: (DataPoint d, _) => d.y,
                                xValueMapper: (DataPoint d, _) => DateTime.parse(d.x),
                                color: Colors.green,
                              ),
                            ],
                          )
                      ),
                      if (tappedXPosition != null)
                        Positioned.fill(
                          left: tappedXPosition!,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 1,
                              color: Colors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const PeriodSelector(),
            ],
          );
        } else if (state is PortfolioError) {
          return Text('Error: ${state.errorMessage}');
        } else {
          return const Text('Unknown state');
        }
      },
      listener: (context, state) {
        // Listener logic goes here if needed
      },
      buildWhen: (previous, current) {
        return true;
      },
    );
  }

  _setupTheme(BuildContext context) {
    final color = T(context, 'primary');
    final highlightSwatch = Theme.of(context).highlightColor;
    _trackballBehavior = TrackballBehavior(
      enable: true,
      lineWidth: 2,
      shouldAlwaysShow: true,
      lineColor: highlightSwatch,
      activationMode: ActivationMode.singleTap,
      tooltipSettings: InteractiveTooltip(
        enable: true,
        borderWidth: 1,
        color: color,
        borderColor: Colors.lightGreenAccent,
      ),
    );
  }
}

