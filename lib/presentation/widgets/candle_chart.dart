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
    hoveredCandle = CandleStick.fact();
    super.initState();
  }

  getWidth(context) {
    var width = MediaQuery.of(context).size.width;
    if (isS(context)) {
      return width;
    } else if (isM(context)) {
      return MediaQuery.of(context).size.width * .8;
    } else {
      return MediaQuery.of(context).size.width * .9;
    }
  }

  getHeight(context) {
    var height = MediaQuery.of(context).size.height;
    if (isS(context)) {
      return height * .5;
    } else if (isM(context)) {
      return height * .35;
    } else {
      return height * .4;
    }
  }

  getPadding(context) {
    if (isS(context)) {
      return const EdgeInsets.symmetric(horizontal: 5, vertical: 5);
    } else if (isM(context)) {
      return const EdgeInsets.symmetric(horizontal: 5, vertical: 5);
    } else {
      return const EdgeInsets.symmetric(horizontal: 5, vertical: 5);
    }
  }

  @override
  Widget build(BuildContext context) {
    _setupTheme(context);
    return Container(
      // color: Colors.blue,
      child: Padding(
        padding: getPadding(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildChart(context),
              if (isS(context)) const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: CandleHoveredDetails(),
              ),
              const PeriodSelector(),
            ],
          ),
        ),
      ),
    );
  }

  buildChart(context) {
    return SizedBox(
      width: getWidth(context),
      height: getHeight(context),
      child: BlocConsumer<AssetCubit, AssetState>(
        builder: (context, state) {
          if (state is AssetLoaded) {
            final asset = context.watch<AssetCubit>();
            final series = asset.current;
            if (previousLow == 0) {
              setState(() {
                previousLow = getLowestVal(series);
                previousHigh = getHighestVal(series);
              });
            }
            if (hoveredCandle?.time == '') {
              final candle = series[0];
              context.read<ChartCubit>().setHoveredPoint(candle, double.infinity);
              hoveredCandle = candle;
            }
            return Column(
              children: [
                ChartHeader(value: series.last.close, startValue: series.first.open),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    if (!isS(context)) const Positioned(
                        top: -40,
                        left: 0,
                        right: 0,
                        child: CandleHoveredDetails()
                    ),
                    SfCartesianChart(
                      plotAreaBorderWidth: 1,
                      zoomPanBehavior: _zoomPanBehavior,
                      trackballBehavior: _trackballBehavior,
                      // crosshairBehavior: showCrosshair ? _crosshairBehavior : null,
                      onChartTouchInteractionDown: (ChartTouchInteractionArgs args) {
                        // setState(() {
                        //   // showCrosshair = !showCrosshair;
                        // });
                      },
                      primaryYAxis: NumericAxis(
                        isVisible: false,
                        numberFormat: NumberFormat.simpleCurrency(locale: 'en_US', decimalDigits: 0),
                        minimum: (series.reduce((value, element) => value.low < element.low ? value : element).low - 1).roundToDouble(),
                      ),
                      onTrackballPositionChanging: (TrackballArgs args) {
                        final xOffSet = args.chartPointInfo.xPosition;
                        final dataPoint = args.chartPointInfo.chartDataPoint!.overallDataPointIndex;
                        final CandleStick candle = series[dataPoint!];
                        context.read<ChartCubit>().setHoveredPoint(candle, xOffSet!);
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
      shouldAlwaysShow: true,
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
      // shouldAlwaysShow: true,
      lineDashArray: <double>[5,5],
      lineType: CrosshairLineType.both,
      activationMode: ActivationMode.singleTap,
    );
  }
}

