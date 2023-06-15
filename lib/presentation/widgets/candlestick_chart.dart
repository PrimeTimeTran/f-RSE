import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/data/models/all.dart';
import 'package:rse/data/cubits/all.dart';
import 'package:rse/presentation/utils/all.dart';
import 'package:rse/presentation/widgets/all.dart';

class PlaceholderScreen extends StatefulWidget {
  @override
  PlacerholderState createState() => PlacerholderState();
}

class PlacerholderState extends State<PlaceholderScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Placeholder Screen'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (isLoading) {
            // Placeholder widget while loading
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // Your content widget
            return const Center(
              child: Text('Content Loaded'),
            );
          }
        },
      ),
    );
  }
}

class ChartBody extends StatelessWidget {
  final List<CandleStick> data;

  const ChartBody({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetCubit, AssetState>(
      builder: (context, state) {
        if (state is AssetInitial) {
          return PlaceholderScreen();
        } else if (state is AssetLoading) {
          return PlaceholderScreen();
        } else if (state is AssetLoaded) {
          return Text('sksk');
        } else if (state is AssetError) {
          return const Center(child: Text('Error'));
        } else {
          return const Center(child: Text('Error'));
        }
      },
    );
  }
}

class CandleStickChart extends StatefulWidget {
  final List<CandleStick> data;

  const CandleStickChart({Key? key, required this.data}) : super(key: key);


  @override
  CandleStickChartState createState() => CandleStickChartState(data: data);
}

class CandleStickChartState extends State<CandleStickChart> {
  late bool isHovered = false;
  final List<CandleStick> data;
  late CandleStick? hoveredCandle;
  late int? hoveredPointIndex = -1;

  CandleStickChartState({required this.data});

  @override
  initState() {
    super.initState();
    hoveredCandle = data.last;
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
      padding: isWeb ? const EdgeInsets.symmetric(horizontal: 40, vertical: 50) : const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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

  void onHoverChart(RenderBox? renderBox, Offset? positionInChart, double labelsWidth, double availableWidth, double candlestickWidth) {
    if (renderBox != null && positionInChart != null && positionInChart.dx >= labelsWidth && positionInChart.dx <= availableWidth) {
      setState(() {
        hoveredPointIndex = _findNearestDataPointIndex(positionInChart.dx - labelsWidth, candlestickWidth);
        isHovered = true;
      });

      if (hoveredPointIndex != null) {
        final CandleStick hoveredCandle = data[hoveredPointIndex!];
        onHoveredCandle(hoveredCandle);
      }
    } else {
      setState(() {
        isHovered = false;
      });
    }
  }

  _buildLayoutBuilder(assetCubit) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double labelsWidth = 50;
        final double availableWidth = constraints.maxWidth;
        final double chartWidth = availableWidth - labelsWidth;
        final double candlestickWidth = chartWidth / (data.length + 1);

        return MouseRegion(
          onHover: (event) {
            final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
            final positionInChart = renderBox?.globalToLocal(event.position);
            onHoverChart(renderBox, positionInChart, labelsWidth, availableWidth, candlestickWidth);
          },
          child: SfCartesianChart(
            primaryYAxis: NumericAxis(
              numberFormat: NumberFormat.simpleCurrency(decimalDigits: 2),
              minimum: (data.reduce((value, element) => value.low < element.low ? value : element).low - 1).roundToDouble(),
            ),
            primaryXAxis: CategoryAxis(
              labelRotation: 45,
              maximumLabels: 30,
              labelPlacement: LabelPlacement.betweenTicks,
              labelIntersectAction: AxisLabelIntersectAction.hide,
              desiredIntervals: calculateIntervals(assetCubit.period.toString()),
            ),
            series: <CandleSeries<CandleStick, String>>[
              CandleSeries<CandleStick, String>(
                dataSource: data,
                lowValueMapper: (CandleStick d, _) => d.low,
                highValueMapper: (CandleStick d, _) => d.high,
                openValueMapper: (CandleStick d, _) => d.open,
                closeValueMapper: (CandleStick d, _) => d.close,
                xValueMapper: (CandleStick d, int index) => chooseFormat(assetCubit.period.toString(), d),
              ),
            ],
            trackballBehavior: TrackballBehavior(
              enable: true,
              lineWidth: 2,
              lineColor: Colors.blue,
              activationMode: ActivationMode.singleTap,
              tooltipSettings: InteractiveTooltip(
                enable: true,
                borderWidth: 1,
                color: Colors.grey[900]!,
                borderColor: Colors.blue,
              ),
            ),
          ),
        );
      },
    );
  }

  int calculateIntervals(period){
    switch (period) {
      case 'live':
        return 5;
      case '1d':
        return (data.length /24).toInt();
      case '1w':
        return 30;
      case '1m':
        return 30;
      case '3m':
        return 30;
      case '1y':
        return 12;
    }
    return 1;
  }

  String chooseFormat(period, d) {
    String val = '';
    switch (period) {
      case 'live':
        val = 'h:mma';
      case '1d':
        val = 'h:mma';
      case '1w':
        val = 'h:mma MMMM d';
      case '1m':
        val = 'h:mma MMMM d';
      case '3m':
        val = 'M/d';
      case '1y':
        val = 'yMd';
    }
    return DateFormat(val).format(DateTime.parse(d.time)).toString();
  }

  Padding _indicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 600),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Open: '),
                Text(formatMoney(hoveredCandle!.open.toString())),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Low: '),
                Text(formatMoney(hoveredCandle!.low.toString())),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('High: '),
                Text(formatMoney(hoveredCandle!.high.toString())),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Close: '),
                Text(formatMoney(hoveredCandle!.close.toString())),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _findNearestDataPointIndex(double xPosition, double width) {
    double minDistance = double.infinity;
    int nearestIndex = -1;

    for (int i = 0; i < data.length; i++) {
      final double distance = (xPosition - (i + 0.5) * width).abs();

      if (distance < minDistance) {
        minDistance = distance;
        nearestIndex = i;
      }
    }

    return nearestIndex;
  }
}
