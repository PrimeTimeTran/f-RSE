import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/all.dart';

class CandleHoveredDetails extends StatelessWidget {
  const CandleHoveredDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var alignment = isS(context) || isM(context) ? MainAxisAlignment.spaceAround : MainAxisAlignment.center;
    return BlocBuilder<ChartCubit, ChartState>(
      builder: (context, state) {
        if (state is UpdatedChart) {
          final c = state.candle;
          return Row(
            mainAxisAlignment: alignment,
            children: [
              IndicatorItem(c.open, 'Open: '),
              IndicatorItem(c.low, 'Low: '),
              IndicatorItem(c.high, 'High: '),
              IndicatorItem(c.close, 'Close: '),
            ],
          );
        } else if (state is ChartPeriodChange) {
          final c = state.candle;
          return Row(
            mainAxisAlignment: alignment,
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
