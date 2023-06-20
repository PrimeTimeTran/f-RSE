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
        child: BlocBuilder<ChartCubit, Chart>(
          builder: (c, state) {
            if (state is Chart) {
              final asset = c.read<AssetCubit>().asset;
              final cursorVal = state.hoveredCandle.value;
              var gain = calculatePercentageChange(cursorVal, asset.o);
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        formatMoney(cursorVal),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${calculateValueChange(cursorVal, asset.o)} ($gain)',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Text('');
            }
          },
        ),
      ),
    );
  }
}
