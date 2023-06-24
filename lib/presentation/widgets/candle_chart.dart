import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/all.dart';

class CandleChart extends StatefulWidget {
  const CandleChart({Key? key }) : super(key: key);

  @override
  CandleChartState createState() => CandleChartState();
}

class CandleChartState extends State<CandleChart> {
  bool showCrosshair = true;
  late double previousLow = 0;
  late double previousHigh = 0;
  late CandleStick? hoveredCandle;
  late ZoomPanBehavior _zoomPanBehavior;
  late CrosshairBehavior _crosshairBehavior;
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    hoveredCandle = CandleStick.fact();
    super.initState();
  }

  getHeight(context) {
    var height = MediaQuery.of(context).size.height;
    if (isS(context)) {
      return height * .5;
    } else if (isM(context)) {
      return height * .425;
    } else if (isL(context)) {
      return height * .425;
    }
      return height * .425;
  }

  @override
  Widget build(BuildContext context) {
    _setupTheme(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          buildChart(context),
          if (isS(context) || isM(context)) const Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: CandleHoveredDetails(),
          ),
          const PeriodSelector(),
        ],
      ),
    );
  }

  buildChart(context) {
    return SizedBox(
      width: double.infinity,
      height: getHeight(context),
      child: BlocBuilder<AssetCubit, AssetState>(
        builder: (context, state) {
          if (state is AssetLoaded) {
            final asset = context.watch<AssetCubit>();
            context.read<ChartCubit>().assetLoaded(asset);
            return chart();
          } else {
            return PlaceholderCandleStickChart(low: previousLow, high: previousHigh);
          }
        }
      ),
    );
  }

  chart() {
    return BlocBuilder<ChartCubit, ChartState>(
        builder: (context, state) {
          if (state is UpdatedChart) {
            final series = state.chart.candleSeries;
            return loadedChart(series);
          } else if (state is HoveringChart) {
            final series = state.chart.candleSeries;
            return loadedChart(series);
          } else {
            return Text('Chart State: $state');
          }
        }
    );
  }

  loadedChart(List<CandleStick> series) {
    return Column(
      children: [
        const ChartHeader(),
        Stack(
          clipBehavior: Clip.none,
          children: [
            if (!isS(context) && !isM(context)) const Positioned(
                top: -40,
                left: 0,
                right: 0,
                child: CandleHoveredDetails()
            ),
            SfCartesianChart(
              plotAreaBorderWidth: 1,
              zoomPanBehavior: _zoomPanBehavior,
              trackballBehavior: _trackballBehavior,
              onChartTouchInteractionDown: (ChartTouchInteractionArgs args) {
              },
              primaryYAxis: NumericAxis(
                isVisible: false,
                numberFormat: NumberFormat.simpleCurrency(locale: 'en_US', decimalDigits: 0),
                minimum: series.length > 0 ? (series.reduce((value, element) => value.low < element.low ? value : element).low - 1).roundToDouble() : 0,
              ),
              onTrackballPositionChanging: (TrackballArgs args) {
                final xOffSet = args.chartPointInfo.xPosition;
                final dataPoint = args.chartPointInfo.chartDataPoint!.overallDataPointIndex;
                final CandleStick candle = series[dataPoint!];
                context.read<ChartCubit>().hoveredChart(null, candle, xOffSet!);
              },
              primaryXAxis: CategoryAxis(
                isVisible: false,
              ),
              series: <CandleSeries<CandleStick, String>>[
                CandleSeries<CandleStick, String>(
                  dataSource: series,
                  lowValueMapper: (CandleStick d, _) => d.low,
                  highValueMapper: (CandleStick d, _) => d.high,
                  openValueMapper: (CandleStick d, _) => d.open,
                  closeValueMapper: (CandleStick d, _) => d.close,
                  xValueMapper: (CandleStick d, int index) => d.time,
                ),
              ],
            ),
            const TimeLabel(),
          ],
        )
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
      lineColor: color,
      shouldAlwaysShow: true,
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
      // shouldAlwaysShow: true,
      lineDashArray: <double>[5,5],
      lineType: CrosshairLineType.both,
      activationMode: ActivationMode.singleTap,
    );
  }
}

