import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/all.dart';
import 'package:rse/presentation/all.dart';

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

  @override
  Widget build(BuildContext context) {
    final color = T(context, 'primary');
    final highlightColor = T(context, 'primary');
    final unselectedColor = Theme.of(context).unselectedWidgetColor;

    final width = isMed(context) ? MediaQuery.of(context).size.width * 0.2 : double.infinity;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 30.0),
        child: SizedBox(
          width: width,
          child: Row(
            mainAxisAlignment: isMed(context) ? MainAxisAlignment.start : MainAxisAlignment.start,
            children: periods.map((p) {
              return Flexible(
                fit: FlexFit.tight,
                child: BlocConsumer<AssetCubit, AssetState>(
                  builder: (c, state) {
                    if (state is AssetLoaded) {
                      final assetCubit = BlocProvider.of<AssetCubit>(context);
                      final current = assetCubit.current;
                      final period = assetCubit.period;
                      return GestureDetector(
                        onTap: () {
                          context.read<ChartCubit>().periodChange(
                              current.first,
                              current.first.open,
                              current.last.close,
                          );
                          logPeriodSelect(p);
                          if (period == p) return;
                          assetCubit.setPeriod(p);
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            margin: const EdgeInsets.only(right: 5.0),
                            decoration: BoxDecoration(
                              border: Border(
                              bottom: BorderSide(width: 1.5, color: period == p ? color : hoveredPeriod == p ? highlightColor : unselectedColor),
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: HoverText(
                                  p,
                                  textStyle: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: period == p ? color : hoveredPeriod == p ? highlightColor : unselectedColor
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
                      );
                    } else {
                      return const Text('');
                    }
                  },
                  listener: (context, state) {
                  },
                  buildWhen: (previous, current) {
                    return true;
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void setPeriod(String period) {}
}