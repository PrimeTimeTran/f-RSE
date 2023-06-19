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
            const CandleHoveredDetails(),
            const ChartHeader(),
            buildChart(),
            const PeriodSelector(),
          ],
        ),
      ),
    );
  }

  BlocConsumer<ChartCubit, ChartState> buildTimeLabel() {
    return BlocConsumer<ChartCubit, ChartState>(
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
    );
  }

  buildChart() {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .5,
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
                    },
                    primaryXAxis: CategoryAxis(
                      isVisible: false,
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
        ),
        buildTimeLabel(),
      ],
    );
  }

  void _setupTheme(BuildContext context) {
    final color = T(context, 'primary');
    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
      enablePinching: true,
      enableMouseWheelZooming : true,
    );
    _trackballBehavior = TrackballBehavior(
      enable: true,
      lineWidth: 1,
      lineColor: Colors.white,
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

