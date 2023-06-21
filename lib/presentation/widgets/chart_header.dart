import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/all.dart';
import 'package:rse/presentation/all.dart';

class ChartHeader extends StatelessWidget {
  const ChartHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 100,
        child: BlocBuilder<ChartCubit, ChartState>(
          builder: (c, state) {
            if (state is HoveredChart) {
              final val = state.type == 'candle' ? c.read<AssetCubit>().asset.o : c.read<PortfolioCubit>().open;
              final cursorVal = state.value;
              var gain = calculatePercentageChange(cursorVal, val);
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        formatMoney(cursorVal),
                        style: TextStyle(
                          color: T(context, 'primary'),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${calculateValueChange(cursorVal, val)} ($gain)',
                        style: TextStyle(
                          color: T(context, 'primary'),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
