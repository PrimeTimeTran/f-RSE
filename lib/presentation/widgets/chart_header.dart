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
            if (state is HoveringChart) {
              final focusedValue = state.chart.focusedPoint.y;
              final val = state.chart.startValue;
              return ChartHeaderDetails(
                val: val,
                title: 'Investing',
                cursorVal: focusedValue,
                gain: calculatePercentageChange(focusedValue, val),
              );
            } else if (state is UpdatedChart) {
              final hoveredValue = state.chart.latestValue;
              final val = state.chart.startValue;
              return ChartHeaderDetails(
                val: val,
                title: state.chart.sym,
                cursorVal: hoveredValue,
                gain: calculatePercentageChange(hoveredValue, val),
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

