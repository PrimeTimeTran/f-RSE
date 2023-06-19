import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/data/all.dart';
import 'package:rse/presentation/all.dart';

class CandleChart extends StatefulWidget {
  const CandleChart({Key? key }) : super(key: key);

  @override
  CandleChartState createState() => CandleChartState();
}

class CandleChartState extends State<CandleChart> {
  bool showCrosshair = true;
  late double previousLow = 10;
  late double previousHigh = 0;
  late CandleStick? hoveredCandle;
  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;
  late CrosshairBehavior _crosshairBehavior;
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    hoveredCandle = CandleStick.defaultCandle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _setupTheme(context);
    return Padding(
      padding: isWeb && isMed(context) ? const EdgeInsets.symmetric(horizontal: 40, vertical: 50) : const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _indicator(),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 100,
                child: BlocConsumer<ChartCubit, ChartState>(
                  builder: (c, state) {
                    if (state is ChartUpdated) {
                      final asset = c.read<AssetCubit>().asset;
                      final cursorVal = state.chart.hoveredCandle.value;
                      var gain = calculatePercentageChange(cursorVal, asset.o);
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                formatMoney(cursorVal),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${calculateValueChange(cursorVal, asset.o)} ($gain)',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Text('');
                    }
                  },
                  listener: (context, state) {
                  }
                ),
              ),
            ),
            Stack(
              children: [
                _buildLayoutBuilder(),
                BlocConsumer<ChartCubit, ChartState>(
                    builder: (c, state) {
                    if (state is ChartUpdated) {
                      final p = c.read<AssetCubit>().period;
                      final candle = state.chart.hoveredCandle;
                      final value = state.chart.xOffSet;
                       return Positioned(
                         top: -10,
                         left: value - 30,
                         child: Container(
                           padding: const EdgeInsets.all(8),
                           // color: T(context, 'primary'),
                           child: Text(
                             candle.time != '' ? chooseFormat(p, candle).toString() : '',
                             style: const TextStyle(
                               fontSize: 16,
                               color: Colors.white,
                             ),
                           ),
                         ),
                       );
                    } else {
                      return const Text('');
                    }
                  },
                  listener: (context, state) {
                  },
                ),
              ],
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: PeriodSelector()
            ),
          ],
        ),
      ),
    );
  }

  _buildLayoutBuilder() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .7,
      child: BlocConsumer<AssetCubit, AssetState>(
        builder: (context, state) {
          if (state is AssetLoaded) {
            final asset = context.read<AssetCubit>();
            final period = asset.period;
            final series = asset.current;
            if (previousLow == 0) {
              setState(() {
                previousLow = getLowestVal(series);
                previousHigh = getHighestVal(series);
              });
            }
            if (hoveredCandle?.time == '') {
              final candle = series[0];
              context.read<ChartCubit>().setHoveredCandle(candle, 0);
              hoveredCandle = candle;
            }
            return RepaintBoundary(
              child: SfCartesianChart(
                tooltipBehavior: _tooltipBehavior,
                zoomPanBehavior: _zoomPanBehavior,
                trackballBehavior: _trackballBehavior,
                crosshairBehavior: showCrosshair ? _crosshairBehavior : null,
                onChartTouchInteractionDown: (ChartTouchInteractionArgs args) {
                  setState(() {
                    showCrosshair = !showCrosshair;
                  });
                },
                primaryYAxis: NumericAxis(
                  numberFormat: NumberFormat.simpleCurrency(locale: 'en_US', decimalDigits: 0),
                  minimum: (series.reduce((value, element) => value.low < element.low ? value : element).low - 1).roundToDouble(),
                ),
                onTrackballPositionChanging: (TrackballArgs args) {
                  final xOffSet = args.chartPointInfo.xPosition;
                  final dataPoint = args.chartPointInfo.chartDataPoint!.overallDataPointIndex;
                  final CandleStick candle = series[dataPoint!];
                  context.read<ChartCubit>().setHoveredCandle(candle, xOffSet!);
                  // context.read<ChartCubit>().setOffsetX(xOffSet!);
                },
                primaryXAxis: CategoryAxis(
                  labelRotation: 45,
                  maximumLabels: 30,
                  labelIntersectAction: AxisLabelIntersectAction.hide,
                  desiredIntervals: calculateIntervals(period.toString(), series),
                ),
                series: <CandleSeries<CandleStick, String>>[
                  CandleSeries<CandleStick, String>(
                    dataSource: series,
                    lowValueMapper: (CandleStick d, _) => d.low,
                    highValueMapper: (CandleStick d, _) => d.high,
                    openValueMapper: (CandleStick d, _) => d.open,
                    closeValueMapper: (CandleStick d, _) => d.close,
                    xValueMapper: (CandleStick d, int index) => chooseFormat(period, d),
                  ),
                ],
              ),
            );
          } else if (state is AssetError) {
            return const Text('Error:');
          } else {
            return PlaceholderCandleStickChart(low: previousLow, high: previousHigh);
          }
        },
        listener: (context, state) {
        },
        buildWhen: (previous, current) {
          return true;
        },
      ),
    );
  }

  Padding _indicator() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: isWeb && isMed(context) ? 600 : 0),
        child: BlocConsumer<ChartCubit, ChartState>(
        builder: (context, state) {
          if (state is ChartInitial) {
            return const CircularProgressIndicator();
          } else if (state is ChartUpdated) {
            final c = state.chart.hoveredCandle;
            return Row(
              children: [
                IndicatorItem(c.open, 'Open: '),
                IndicatorItem(c.low, 'Low: '),
                IndicatorItem(c.high, 'High: '),
                IndicatorItem(c.close, 'Close: '),
              ],
            );
          } else if (state is ChartError) {
            return Text('Error: ${state.errorMessage}');
          } else {
            return const Text('Error');
          }
        },
        listener: (context, state) {
        },
        buildWhen: (previous, current) {
          return true;
        },
      )
    );
  }

  void _setupTheme(BuildContext context) {
    final color = T(context, 'primary');
    _tooltipBehavior = TooltipBehavior(
      // enable: true,
    );
    _zoomPanBehavior = ZoomPanBehavior(
        enablePanning: true,
        enablePinching: true,
        enableMouseWheelZooming : true,
    );
    _trackballBehavior = TrackballBehavior(
      enable: true,
      lineWidth: 0,
      lineColor: color,
      lineType: TrackballLineType.vertical,
      activationMode: ActivationMode.singleTap,
      tooltipSettings: const InteractiveTooltip(
        enable: false,
      ),
    );
    _crosshairBehavior = CrosshairBehavior(
      enable: true,
      lineWidth: 2,
      hideDelay: 5,
      lineColor: color,
      shouldAlwaysShow: true,
      lineDashArray: <double>[5,5],
      lineType: CrosshairLineType.both,
      activationMode: ActivationMode.singleTap,
    );
  }
}

