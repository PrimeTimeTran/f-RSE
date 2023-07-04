import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:rse/all.dart';

class PeriodSelector extends StatefulWidget {
  const PeriodSelector({super.key});

  @override
  PeriodSelectorState createState() => PeriodSelectorState();
}

class PeriodSelectorState extends State<PeriodSelector> {
  late String hoveredPeriod;
  final List<String> periods = ['live', '1d', '1w', '1m', '3m', 'ytd', '1y'];

  @override
  void initState() {
    super.initState();
    hoveredPeriod = '';
  }

  getWidth(c) {
    if (isS(c)) {
      return 1;
    } else if (isM(c)) {
      return .7;
    } else if (isL(c)) {
      return .5;
    } else {
      return .3;
    }
  }

  getTextSize(context) {
    if (isS(context)) {
      return 10.0;
    } else if (isM(context)) {
      return 10.0;
    } else if (isL(context)) {
      return 10.0;
    }
    return 10.0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChartBloc, ChartState>(
      builder: (context, state) {
        return buildSelector(context);
      },
      listener: (context, state) {
      },
      buildWhen: (previous, current) {
        return true;
      },
    );
  }

  buildSelector(context) {
    final highlightColor = T(context, 'primary');
    final unselectedColor = Theme.of(context).unselectedWidgetColor;

    final portfolioBloc = BlocProvider.of<PortfolioBloc>(context);
    final assetBloc = BlocProvider.of<AssetBloc>(context);

    final isHome = GoRouter.of(context).location == '/';
    final period = isHome ? portfolioBloc.portfolio.period : assetBloc.period;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 30.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * getWidth(context),
          child: Row(
            mainAxisAlignment: isM(context) ? MainAxisAlignment.start : MainAxisAlignment.start,
            children: periods.map((p) {
              final color = period == p ? T(context, 'primary') : hoveredPeriod == p ? highlightColor : unselectedColor;
              return Flexible(
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: () {
                    logPeriodSelect(p);
                    if (period == p) return;
                    if (isHome) {
                      portfolioBloc.setPeriod(p);
                    } else {
                      assetBloc.setPeriod(p);
                    }
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      margin: const EdgeInsets.only(right: 5.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.5, color: color),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: HoverText(
                            p,
                            textStyle: TextStyle(
                              color: color,
                              fontWeight: FontWeight.bold,
                              fontSize: getTextSize(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                    onHover: (_) {
                      setState(() {
                        hoveredPeriod = p;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        hoveredPeriod = '';
                      });
                    },
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}