import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/all.dart';

class ChartHeader extends StatelessWidget {
  const ChartHeader();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 100,
        child: BlocConsumer<ChartBloc, ChartState>(
          builder: (context, state) {
            if (state is HoveringLineChart) {
              final focusedValue = state.chart.focusedPoint.y;
              final startValue = state.chart.portfolioStartValue;
              return ChartHeaderDetails(
                hovering: true,
                title: 'Investing',
                startValue: startValue,
                focusValue: focusedValue,
                gain: calculatePercentageChange(focusedValue, startValue),
              );
            } else if (state is HoveringChart) {
              final focusedValue = state.chart.focusedPoint.y;
              final startValue = state.chart.assetStartValue;
              return ChartHeaderDetails(
                hovering: true,
                title: state.chart.sym,
                startValue: startValue,
                focusValue: focusedValue,
                gain: calculatePercentageChange(focusedValue, startValue),
              );
            } else if (state is UpdatedChart) {
              final focusedValue = state.chart.latestValue;
              final startValue = state.chart.sym == 'Investing' ? state.chart.startValue : state.chart.assetStartValue;
              return ChartHeaderDetails(
                hovering: false,
                startValue: startValue,
                title: state.chart.sym,
                focusValue: focusedValue,
                gain: calculatePercentageChange(focusedValue, startValue),
              );
            } else {
              return const SizedBox();
            }
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}

