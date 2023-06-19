import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/all.dart';
import 'package:rse/presentation/all.dart';

class CandleHoveredDetails extends StatelessWidget {
  const CandleHoveredDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChartCubit, ChartState>(
      builder: (context, state) {
        if (state is ChartInitial) {
          return const CircularProgressIndicator();
        } else if (state is ChartUpdated) {
          final c = state.chart.hoveredCandle;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IndicatorItem(c.open, 'Open: '),
              IndicatorItem(c.low, 'Low: '),
              IndicatorItem(c.high, 'High: '),
              IndicatorItem(c.close, 'Close: '),
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
    );
  }
}
