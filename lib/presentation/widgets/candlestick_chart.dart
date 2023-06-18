import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/data/models/all.dart';
import 'package:rse/data/cubits/all.dart';
import 'package:rse/presentation/utils/all.dart';
import 'package:rse/presentation/widgets/all.dart';

class CandleStickChart extends StatefulWidget {
  const CandleStickChart({Key? key }) : super(key: key);

  @override
  CandleStickChartState createState() => CandleStickChartState();
}

class CandleStickChartState extends State<CandleStickChart> {
  late CandleStick? hoveredCandle;
  late TooltipBehavior _tooltipBehavior;
  late CrosshairBehavior _crosshairBehavior;
  late TrackballBehavior _trackballBehavior;

  @override
  initState() {
    _tooltipBehavior = TooltipBehavior(
      enable: true,
    );

    _trackballBehavior = TrackballBehavior(
      enable: true,
      lineWidth: 0,
      lineColor: Colors.blue,
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
        lineColor: Colors.red,
        shouldAlwaysShow: true,
        lineDashArray: <double>[5,5],
        lineType: CrosshairLineType.both,
        activationMode: ActivationMode.singleTap,
    );
    hoveredCandle = CandleStick.defaultCandle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isWeb ? const EdgeInsets.symmetric(horizontal: 40, vertical: 50) : const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        children: [
          _indicator(),
          _buildLayoutBuilder(),
          PeriodSelector(),
        ],
      ),
    );
  }

  _buildLayoutBuilder() {
    return BlocConsumer<AssetCubit, AssetState>(
      builder: (context, state) {
        if (state is AssetLoading) {
          return const PlaceholderCandleStickChart();
        } else if (state is AssetLoaded) {
          final series = context.read<AssetCubit>().current;
          final period = context.read<AssetCubit>().period;
          final sym = context.read<AssetCubit>().sym;
          if (hoveredCandle?.time == '') {
            final candle = series[0];
            context.read<ChartCubit>().setHoveredSeriesItem(candle);
          }
          return SfCartesianChart(
            tooltipBehavior: _tooltipBehavior,
            crosshairBehavior: _crosshairBehavior,
            trackballBehavior: _trackballBehavior,
            title:  ChartTitle(
                text: sym,
                borderWidth: 2,
                alignment: ChartAlignment.near,
                textStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.italic,
                )
            ),
            primaryYAxis: NumericAxis(
              numberFormat: NumberFormat.simpleCurrency(decimalDigits: 2),
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
          );
        } else if (state is PortfolioError) {
          return const Text('Error:');
        } else {
          return const PlaceholderCandleStickChart();
        }
      },
      listener: (context, state) {
      },
      buildWhen: (previous, current) {
        return true;
      },
    );
  }

  Padding _indicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 600),
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



