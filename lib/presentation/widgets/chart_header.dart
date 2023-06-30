import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/all.dart';

class ChartHeader extends StatelessWidget {
  const ChartHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: 100,
          child: BlocConsumer<ChartBloc, ChartState>(
            builder: (context, state) {
              if (state is ChartFocus) {
                final startValue = state.chart.startValue;
                final focusedValue = state.chart.focusedValue;
                return ChartHeaderDetails(
                  hovering: true,
                  title: state.chart.sym,
                  startValue: startValue,
                  focusValue: focusedValue,
                  gain: calculatePercentageChange(focusedValue, startValue),
                );
              } else if (state is UpdatedChart) {
                final focusedValue = state.chart.latestValue;
                final startValue = state.chart.startValue;
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
      ),
    );
  }
}

