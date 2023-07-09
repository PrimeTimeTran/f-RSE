import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';

import 'package:rse/all.dart';

class ChartHeaderDetails extends StatelessWidget {
  final String gain;
  final String title;
  final bool hovering;
  final double startValue;
  final double focusValue;

  const ChartHeaderDetails({
    super.key,
    required this.gain,
    required this.title,
    required this.hovering,
    required this.focusValue,
    required this.startValue,
  });

  getPrompt(p, BuildContext context) {
    switch (p) {
      case 'live':
        return context.l.live;
      case '1d':
        return context.l.today;
      case '1w':
        return context.l.past_week;
      case '1m':
        return context.l.past_month;
      case '3m':
        return context.l.past_three_months;
      case 'ytd':
        return context.l.ytd;
      case '1y':
        return context.l.past_year;
      default:
        return context.l.all_time;
    }
  }

  getFontSize(context) {
    if (isS(context)) {
      return 14.0;
    }
    return 20;
  }

  @override
  Widget build(BuildContext context) {
    final isHome = GoRouterState.of(context).location == '/';
    final portfolioBloc = BlocProvider.of<PortfolioBloc>(context);
    final assetBloc = BlocProvider.of<AssetBloc>(context);
    var prompt = isHome ? portfolioBloc.portfolio.period : assetBloc.period;
    prompt = getPrompt(prompt, context);

    final gained = getChangePercent(focusValue, startValue) >= 0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: T(context, 'inversePrimary'),
                  fontSize: getFontSize(context) + 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AnimatedFlipCounter(
                prefix: '\$',
                value: focusValue,
                fractionDigits: 2,
                thousandSeparator: ',',
                duration: const Duration(milliseconds: 500),
                textStyle: TextStyle(
                  color: T(context, 'inversePrimary'),
                  fontSize: getFontSize(context) + 8,
                  fontWeight: FontWeight.bold,
                )
              ),
              Row(
                children: [
                  AnimatedFlipCounter(
                      prefix: '\$',
                      fractionDigits: 2,
                      thousandSeparator: ',',
                      value: focusValue - startValue,
                      duration: const Duration(milliseconds: 500),
                      textStyle: TextStyle(
                      color: gained ? T(context, 'primary') : Colors.red,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    ' ($gain)',
                    style: TextStyle(
                      color: gained ? T(context, 'primary') : Colors.red,
                      fontSize: 14,
                    ),
                  ),
                  if (!hovering)
                    Text(
                      prompt,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        if (!isS(context))
          const Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AlertIcon(sym: 'bac')
              ],
            ),
          )
      ],
    );
  }
}
