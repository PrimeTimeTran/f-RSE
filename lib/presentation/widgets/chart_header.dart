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
    final route = GoRouter.of(context).location;
    var title = route == '/' || route == '/spending' ? 'Investing' : route.substring(1);

    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 100,
        child: BlocBuilder<ChartCubit, ChartState>(
          builder: (c, state) {
            if (state is PickedNewPoint) {
              // print("PickedNewPoint: ${value} ${startValue}");
              final focusedValue = state.value;
              final val = state.type == 'candle' ? c.read<AssetCubit>().asset.o : c.watch<ChartCubit>().startValue;
              return ChartHeaderDetails(
                val: val,
                title: title,
                cursorVal: focusedValue,
                gain: calculatePercentageChange(focusedValue, val),
              );
            } else if (state is ChartPeriodChange) {
              final chart =  c.watch<ChartCubit>();
              final cursorVal = state.value;
              final val = state.type == 'candle' ? state.startValue : chart.startValue;
              return ChartHeaderDetails(
                val: startValue,
                title: title,
                cursorVal: value,
                gain: calculatePercentageChange(cursorVal, val),
              );
            } else if (state is UpdatedChart) {
              final focusedValue = state.value;
              final val = state.type == 'candle' ? c.read<AssetCubit>().asset.o : c.watch<ChartCubit>().startValue;
              return ChartHeaderDetails(
                val: val,
                title: title,
                cursorVal: focusedValue,
                gain: calculatePercentageChange(focusedValue, val),
              );
            } else {
              return ChartHeaderDetails(
                val: startValue,
                title: 'Investing',
                cursorVal: value,
                gain: calculatePercentageChange(value, startValue),
              );
            }
          }
        ),
      ),
    );
  }
}
