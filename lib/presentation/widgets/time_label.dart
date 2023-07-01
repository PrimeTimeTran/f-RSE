import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:rse/all.dart';

class TimeLabel extends StatelessWidget {
  const TimeLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartBloc, ChartState>(
        builder: (c, state) {
          if (state is ChartFocusSuccess) {
            final isHome = GoRouter.of(context).location == '/home';
            final portfolioBloc = BlocProvider.of<PortfolioBloc>(context);
            final assetBloc = BlocProvider.of<AssetBloc>(context);
            var period = isHome ? portfolioBloc.portfolio.period : assetBloc.period;
            return buildTimeLabel(context, period, state.chart.xOffSet, state.chart.time);
          } else {
            return const SizedBox.shrink();
          }
        }
    );
  }

  buildTimeLabel(c, p, value, time) {
    final formatted = chooseFormat(p, time);
    final length = formatted.length / 2;
    return Positioned(
      top: -10,
      left: value - length,
      child: Text(
        time == '' ? '' :  formatted,
        style: TextStyle(
          fontSize: 10,
          color: T(c, 'inversePrimary'),
        ),
      ),
    );
  }
}