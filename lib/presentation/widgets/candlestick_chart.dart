import 'dart:js_interop';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/data/models/all.dart';
import 'package:rse/data/cubits/all.dart';
import 'package:rse/presentation/utils/all.dart';
import 'package:rse/presentation/widgets/all.dart';

class CandleStickChart extends StatefulWidget {
  final List<CandleStick> data;

  const CandleStickChart({Key? key, required this.data}) : super(key: key);

  @override
  CandleStickChartState createState() => CandleStickChartState(data);
}

class CandleStickChartState extends State<CandleStickChart> {
  late bool isHovered = false;
  final List<CandleStick> data;
  late CandleStick? hoveredCandle;
  late int? hoveredPointIndex = -1;
  late TooltipBehavior _tooltipBehavior;
  late CrosshairBehavior _crosshairBehavior;
  late TrackballBehavior _trackballBehavior;

  CandleStickChartState(this.data);

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
        hideDelay: 5  ,
        lineColor: Colors.red,
        shouldAlwaysShow: true,
        lineDashArray: <double>[5,5],
        lineType: CrosshairLineType.both,
        activationMode: ActivationMode.singleTap,
    );
    hoveredCandle = data.last;
    super.initState();
  }

  onHoveredCandle(CandleStick candle) {
    setState(() {
      hoveredCandle = candle;
    });
  }

  @override
  Widget build(BuildContext context) {
    final assetCubit = BlocProvider.of<AssetCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
      child: Column(
        children: [
          _indicator(),
          _buildLayoutBuilder(assetCubit),
          const PeriodSelector(
            periods: ['live', '1d', '1w', '1m', '3m', '1y'],
          ),
        ],
      ),
    );
  }

  _buildLayoutBuilder(AssetCubit assetCubit) {
    return SfCartesianChart(
      tooltipBehavior: _tooltipBehavior,
      crosshairBehavior: _crosshairBehavior,
      trackballBehavior: _trackballBehavior,
      primaryYAxis: NumericAxis(
        numberFormat: NumberFormat.simpleCurrency(decimalDigits: 2),
        minimum: (data.reduce((value, element) => value.low < element.low ? value : element).low - 1).roundToDouble(),
      ),
      indicators: <TechnicalIndicators>[
        BollingerBandIndicator<dynamic, dynamic>(
          period: 20,
          standardDeviation: 2,
        ),
      ],
      onTrackballPositionChanging: (TrackballArgs args) {
        if (args != null && args.chartPointInfo != null) {
          final dataPoint = args.chartPointInfo.chartDataPoint!.overallDataPointIndex;
          final CandleStick candle = data[dataPoint!];
          context.read<PortfolioCubit>().setHoveredCandle(candle);
        }
      },
      primaryXAxis: CategoryAxis(
        labelRotation: 45,
        maximumLabels: 30,
        labelPlacement: LabelPlacement.betweenTicks,
        labelIntersectAction: AxisLabelIntersectAction.hide,
        desiredIntervals: calculateIntervals(assetCubit.period.toString(), data),
      ),
      series: <CandleSeries<CandleStick, String>>[
        CandleSeries<CandleStick, String>(
          dataSource: data,
          enableTooltip: true,
          lowValueMapper: (CandleStick d, _) => d.low,
          highValueMapper: (CandleStick d, _) => d.high,
          openValueMapper: (CandleStick d, _) => d.open,
          closeValueMapper: (CandleStick d, _) => d.close,
          xValueMapper: (CandleStick d, int index) => chooseFormat(assetCubit.period, d, index),
        ),
      ],
    );
  }

  Padding _indicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 600),
      child: BlocConsumer<PortfolioCubit, PortfolioState>(
        builder: (context, state) {
          if (state is PortfolioLoading) {
            return const CircularProgressIndicator();
          } else if (state is CandleLoaded) {
            final c = context.read<PortfolioCubit>().candle;
            return Row(
              children: [
                _indicatorItem(c.open, 'Open: '),
                _indicatorItem(c.low, 'Low: '),
                _indicatorItem(c.high, 'High: '),
                _indicatorItem(c.close, 'Close: '),
              ],
            );
          } else if (state is PortfolioError) {
            return Text('Error: ${state.errorMessage}');
          } else {
            return const Text('');
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

String chooseFormat(String period, d, int index) {
  final map = {
    'live': 'h:mma',
    '1d': 'h:mma',
    '1w': 'h:mma MMMM d',
    '1m': 'h:mma MMMM d',
    '3m': 'M/d',
  };

  final dateFormat = map[period] ?? 'yMd';
  return DateFormat(dateFormat).format(DateTime.parse(d.time)).toString();
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

int calculateIntervals(period, data){
  final map = {
    'live': 5,
    '1d': data.length ~/ 24,
    '1w': 30,
    '1m': 30,
    '3m': 30,
    '1y': 12,
  };

  return map[period] ?? 0;
}


