import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/all.dart';
import 'package:rse/presentation/all.dart';

class TimeLabel extends StatelessWidget {
  const TimeLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartCubit, ChartState>(
        builder: (c, state) {
          if (state is HoveredChart) {
            final p = c.read<AssetCubit>().period;
            return buildTimeLabel(context, p, state.offset, state.time);
          } else {
            return const SizedBox.shrink();
          }
        }
    );
  }

  buildTimeLabel(c, p, value, time) {
    return Positioned(
      top: -10,
      left: value - 30,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Text(
          time == '' ? '' :  chooseFormat(p, time),
          style: TextStyle(
            fontSize: 16,
            color: T(c, 'inversePrimary'),
          ),
        ),
      ),
    );
  }
}