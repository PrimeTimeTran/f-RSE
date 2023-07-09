import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/all.dart';

class CandleHoveredDetails extends StatelessWidget {
  const CandleHoveredDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartBloc, ChartState>(
      builder: (context, state) {
        if (state is ChartUpdateSuccess) {
          return buildCandleItem(context, state.chart.candle);
        } else if (state is ChartFocusSuccess) {
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
        IndicatorItem(c.o, 'Open: '),
        IndicatorItem(c.l, 'Low: '),
        IndicatorItem(c.h, 'High: '),
        IndicatorItem(c.c, 'Close: '),
      ],
    );
  }
}
