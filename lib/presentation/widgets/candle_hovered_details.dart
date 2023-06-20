import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/all.dart';
import 'package:rse/presentation/all.dart';

class CandleHoveredDetails extends StatelessWidget {
  const CandleHoveredDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartCubit, Chart>(
      builder: (context, state) {
        if (state is Chart) {
          final c = state.hoveredCandle;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IndicatorItem(c.open, 'Open: '),
              IndicatorItem(c.low, 'Low: '),
              IndicatorItem(c.high, 'High: '),
              IndicatorItem(c.close, 'Close: '),
            ],
          );
        } else {
          return const Text('Error');
        }
      }
    );
  }
}
