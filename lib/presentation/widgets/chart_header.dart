import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/all.dart';

class ChartHeader extends StatelessWidget {
  const ChartHeader();

  @override
  Widget build(BuildContext context) {
    final route = GoRouter.of(context).location;
    var title = route == '/' || route == '/spending' ? 'Investing' : route.substring(1);

    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 100,
        child: BlocConsumer<ChartCubit, ChartState>(
          builder: (context, state) {
            if (state is HoveringLineChart) {
              final focusedValue = state.chart.focusedPoint.y;
              final startValue = state.chart.portfolioStartValue;
              return ChartHeaderDetails(
                title: 'Investing',
                startValue: startValue,
                focusValue: focusedValue,
                gain: calculatePercentageChange(focusedValue, startValue),
              );
            } else if (state is HoveringChart) {
              final focusedValue = state.chart.focusedPoint.y;
              final startValue = state.chart.startValue;
              return ChartHeaderDetails(
                title: 'HoveringChart',
                startValue: startValue,
                focusValue: focusedValue,
                gain: calculatePercentageChange(focusedValue, startValue),
              );
            } else if (state is UpdatedChart) {
              final focusedValue = state.chart.latestValue;
              final startValue = state.chart.startValue;
              return ChartHeaderDetails(
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

