import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/all.dart';

class CandleHoveredDetails extends StatelessWidget {
  const CandleHoveredDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartBloc, ChartState>(
      builder: (context, state) {
        if (state is UpdatedChart) {
          return buildCandleItem(context, state.chart.candle);
        } else if (state is ChartFocus) {
          return buildCandleItem(context, state.chart.candle);
        } else {
          return const SizedBox();
        }
      }
    );
  }

  buildCandleItem(context, c) {
    final alignment = isS(context) || isM(context) ? MainAxisAlignment.spaceAround : MainAxisAlignment.center;
    return Row(
      mainAxisAlignment: alignment,
      children: [
        IndicatorItem(c.open, 'Open: '),
        IndicatorItem(c.low, 'Low: '),
        IndicatorItem(c.high, 'High: '),
        IndicatorItem(c.close, 'Close: '),
      ],
    );
  }
}
