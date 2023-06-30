import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/all.dart';

class TimeLabel extends StatelessWidget {
  const TimeLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartBloc, ChartState>(
        builder: (c, state) {
          if (state is ChartFocusSuccess) {
            final p = c.read<AssetBloc>().period;
            // state.chart.period;
            return buildTimeLabel(context, p, state.chart.xOffSet, state.chart.time);
          } else {
            return const SizedBox.shrink();
          }
        }
    );
  }

  buildTimeLabel(c, p, value, time) {
    var length = chooseFormat(p, time).length / 2;
    return Positioned(
      top: -10,
      left: value - length,
      child: Text(
        time == '' ? '' :  chooseFormat(p, time),
        style: TextStyle(
          fontSize: 10,
          color: T(c, 'inversePrimary'),
        ),
      ),
    );
  }
}