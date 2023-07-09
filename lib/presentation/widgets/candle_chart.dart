import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/all.dart';

class CandleChart extends StatefulWidget {
  const CandleChart({Key? key}) : super(key: key);

  @override
  CandleChartState createState() => CandleChartState();
}

class CandleChartState extends State<CandleChart> {
  late CandleStick? hoveredCandle;
  late ZoomPanBehavior _zoomPanBehavior;
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    hoveredCandle = CandleStick.defaultCandleStick();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _setupTheme(context);
    return BlocBuilder<AssetBloc, AssetState>(
      builder: (context, state) {
        if (state is AssetLoaded) {
          return buildChartBody(state.asset.current);
        } else {
          return Text('Error: $state');
        }
      },
    );
  }

  buildChartBody(List<CandleStick> data) {
    return Column(
      children: [
        Column(
          children: [
            const ChartHeader(),
            Stack(
              clipBehavior: Clip.none,
              children: [
                if (!isS(context) && !isM(context))
                  const Positioned(
                    top: -40,
                    left: 0,
                    right: 0,
                    child: CandleHoveredDetails(),
                  ),
                SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  zoomPanBehavior: _zoomPanBehavior,
                  trackballBehavior: _trackballBehavior,
                  primaryXAxis: CategoryAxis(
                    isVisible: false,
                  ),
                  onTrackballPositionChanging: (TrackballArgs args) {
                    final xOffSet = args.chartPointInfo.xPosition;
                    final dataPoint = args
                        .chartPointInfo.chartDataPoint!.overallDataPointIndex;
                    final CandleStick candle = data[dataPoint!];
                    context.read<ChartBloc>().hoveredChart(candle, xOffSet!);
                  },
                  series: <CandleSeries<CandleStick, String>>[
                    CandleSeries<CandleStick, String>(
                      dataSource: data,
                      lowValueMapper: (CandleStick d, _) => d.l,
                      highValueMapper: (CandleStick d, _) => d.h,
                      openValueMapper: (CandleStick d, _) => d.o,
                      closeValueMapper: (CandleStick d, _) => d.c,
                      xValueMapper: (CandleStick d, int index) => d.time,
                    ),
                  ],
                  primaryYAxis: NumericAxis(
                    isVisible: false,
                    minimum: getLowestVal(data),
                    maximum: getHighestVal(data),
                    plotBands: [
                      PlotBand(
                        opacity: 0.5,
                        borderWidth: 1,
                        end: data.first.c,
                        start: data.first.c,
                        dashArray: const [1, 3],
                        borderColor: T(context, 'inversePrimary'),
                      ),
                    ],
                  ),
                ),
                const TimeLabel(),
              ],
            )
          ],
        ),
        if (isS(context) || isM(context))
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: CandleHoveredDetails(),
          ),
        const PeriodSelector(),
      ],
    );
  }

  void _setupTheme(BuildContext context) {
    final color = T(context, 'primary');
    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
      enablePinching: true,
      enableMouseWheelZooming: true,
    );
    _trackballBehavior = TrackballBehavior(
      enable: true,
      lineWidth: 1,
      lineColor: color,
      shouldAlwaysShow: true,
      lineType: TrackballLineType.vertical,
      activationMode: ActivationMode.singleTap,
      tooltipSettings: const InteractiveTooltip(enable: false),
    );
  }
}
