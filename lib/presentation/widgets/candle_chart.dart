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
  late CandleStick? hoveredCandle;
  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;
  late CrosshairBehavior _crosshairBehavior;
  late TrackballBehavior _trackballBehavior;
  late double previousLow = 10;
  late double previousHigh = 0;

  @override
  Widget build(BuildContext context) {
    _setupTheme(context);
    return Padding(
      padding: isWeb && isMed(context) ? const EdgeInsets.symmetric(horizontal: 40, vertical: 50) : const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _indicator(),
            _buildLayoutBuilder(context),
            const Align(
              alignment: Alignment.centerLeft,
              child: PeriodSelector()
            ),
          ],
        ),
      ),
    );
  }

  _buildLayoutBuilder(c) {
    final color = T(context, 'primary');
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .7,
      child: BlocConsumer<AssetCubit, AssetState>(
        builder: (context, state) {
          if (state is AssetLoaded) {
            final sym = context.read<AssetCubit>().sym;
            final period = context.read<AssetCubit>().period;
            final series = context.read<AssetCubit>().current;
            if(previousLow == 0) {
              setState(() {
                previousLow = series.reduce((value, element) => value.low < element.low ? value : element).low;
                previousHigh = series.reduce((value, element) => value.high > element.high ? value : element).high;
              });

            }
            if (hoveredCandle?.time == '') {
              final candle = series[0];
              context.read<ChartCubit>().setHoveredSeriesItem(candle);
            }
            return RepaintBoundary(
              child: SfCartesianChart(
                tooltipBehavior: _tooltipBehavior,
                zoomPanBehavior: _zoomPanBehavior,
                crosshairBehavior: _crosshairBehavior,
                trackballBehavior: _trackballBehavior,
                primaryYAxis: NumericAxis(
                  numberFormat: NumberFormat.simpleCurrency(locale: 'en_US', decimalDigits: 0),
                  minimum: (series.reduce((value, element) => value.low < element.low ? value : element).low - 1).roundToDouble(),
                ),
                onTrackballPositionChanging: (TrackballArgs args) {
                  final dataPoint = args.chartPointInfo.chartDataPoint!.overallDataPointIndex;
                  final CandleStick candle = series[dataPoint!];
                  context.read<ChartCubit>().setHoveredSeriesItem(candle);
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
                title: ChartTitle(
                    text: sym,
                    borderWidth: 2,
                    alignment: ChartAlignment.near,
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: color,
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.italic,
                    )
                ),
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
          } else if (state is ChartLoaded) {
            final c = context.read<ChartCubit>().candle;
            return Row(
              children: [
                _indicatorItem(c.open, 'Open: '),
                _indicatorItem(c.low, 'Low: '),
                _indicatorItem(c.high, 'High: '),
                _indicatorItem(c.close, 'Close: '),
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
      enable: true,
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
    hoveredCandle = CandleStick.defaultCandle();
  }
}

Expanded _indicatorItem(double price, String title) {
  return Expanded(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title),
        Text(
          formatMoney(price.toString()),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}



