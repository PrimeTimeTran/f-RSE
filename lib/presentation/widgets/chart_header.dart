import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/all.dart';
import 'package:rse/presentation/all.dart';

class ChartHeader extends StatelessWidget {
  final double value;
  final double startValue;
  const ChartHeader({super.key, required this.value, required this.startValue});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 100,
        child: BlocBuilder<ChartCubit, ChartState>(
          builder: (c, state) {
            if (state is UpdatedChart) {
              final cursorVal = state.value;
              final val = state.type == 'candle' ? c.read<AssetCubit>().asset.o : c.watch<ChartCubit>().startValue;
              final gain = calculatePercentageChange(cursorVal, val);
              final route = GoRouter.of(context).location;
              var title = route == '/' || route == '/spending' ? 'Investing' : route.substring(1);

              return ChartHeaderDetails(
                val: val,
                gain: gain,
                title: title,
                cursorVal: cursorVal,
              );
            } else {
              return ChartHeaderDetails(
                val: startValue,
                cursorVal: value,
                title: 'Investing',
                gain: calculatePercentageChange(value, startValue),
              );
            }
          }
        ),
      ),
    );
  }
}
