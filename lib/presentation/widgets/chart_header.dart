import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
              final cursorVal = state.value;
              final goRouter = GoRouter.of(context);
              final currentRoute = goRouter.location;
              final val = state.type == 'candle' ? c.read<AssetCubit>().asset.o : c.read<PortfolioCubit>().open;

              final gain = calculatePercentageChange(cursorVal, val);

              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (currentRoute.length > 1) Text(
                      currentRoute.substring(1),
                      style: TextStyle(
                        color: T(context, 'primary'),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        formatMoney(cursorVal),
                        style: TextStyle(
                          color: T(context, 'primary'),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${calculateValueChange(cursorVal, val)} ($gain)',
                        style: TextStyle(
                          color: T(context, 'inversePrimary'),
                          fontSize: 14,
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
