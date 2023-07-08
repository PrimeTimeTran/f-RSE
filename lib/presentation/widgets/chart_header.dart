import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:rse/all.dart';

class ChartHeader extends StatelessWidget {
  const ChartHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: 100,
          child: BlocConsumer<ChartBloc, ChartState>(
            builder: (context, state) {
              if (state is ChartFocusSuccess) {
                final startValue = state.chart.startValue;
                final focusedValue = state.chart.focusedValue;
                return ChartHeaderDetails(
                  hovering: true,
                  title: state.chart.sym,
                  startValue: startValue,
                  focusValue: focusedValue,
                  gain: calculatePercentageChange(focusedValue, startValue),
                );
              } else if (state is ChartUpdateSuccess) {
                final startValue = state.chart.startValue;
                final focusedValue = state.chart.latestValue;
                final isHome = GoRouterState.of(context).location.length == 1;

                // Race condition:
                // Asset vs Portfolio
                return ChartHeaderDetails(
                  hovering: false,
                  startValue: startValue,
                  title: isHome ? context.l.investing : state.chart.sym,
                  focusValue: focusedValue,
                  gain: calculatePercentageChange(focusedValue, startValue),
                );
              }
              return const SizedBox();
            },
            listener: (context, state) {},
          ),
        ),
      ),
    );
  }
}
