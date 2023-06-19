import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/cubits/all.dart';
import 'package:rse/presentation/all.dart';

class PeriodSelector extends StatefulWidget {
  const PeriodSelector({super.key});

  @override
  PeriodSelectorState createState() => PeriodSelectorState();
}

class PeriodSelectorState extends State<PeriodSelector> {
  late String hoveredPeriod;
  final List<String> periods = ['live', '1d', '1w', '1m', '3m', '1y'];

  @override
  void initState() {
    super.initState();
    hoveredPeriod = '';
  }

  @override
  Widget build(BuildContext context) {
    final primarySwatch = Theme.of(context).primaryColor;
    final highlightColor = Theme.of(context).highlightColor;
    final unselectedColor = Theme.of(context).unselectedWidgetColor;

    final width = isMed(context) ? MediaQuery.of(context).size.width * 0.5 : double.infinity;

    return SizedBox(
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
                  final period = assetCubit.period;
                  return GestureDetector(
                    onTap: () {
                      assetCubit.setPeriod(p);
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        height: 30,
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: period == p ? primarySwatch : hoveredPeriod == p ? highlightColor : unselectedColor),
                          // border: Border(
                          //     bottom: BorderSide(width: 2.0, color: period == p ? primarySwatch : hoveredPeriod == p ? highlightColor : unselectedColor),
                          //   )
                        ),
                        child: Center(
                          child: HoverText(
                            p,
                            textStyle: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: period == p ? primarySwatch : hoveredPeriod == p ? highlightColor : unselectedColor
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
                  return Container(
                    height: 30,
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: unselectedColor),
                    ),
                    child: Center(
                      child: HoverText(
                        p,
                        textStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: unselectedColor
                        ),
                      ),
                    ),
                  );
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
    );
  }

  void setPeriod(String period) {}
}