import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/cubits/all.dart';

class PeriodSelector extends StatelessWidget {
  final List<String> periods;
  const PeriodSelector({ super.key, required this.periods });

  changePeriod(String p, assetCubit) {
    assetCubit.setPeriod(p);
  }

  @override
  Widget build(BuildContext context) {
    final assetCubit = BlocProvider.of<AssetCubit>(context);
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: periods.map((p) {
          return Flexible(
            fit: FlexFit.tight,
            child: GestureDetector(
              onTap: () {
                if(assetCubit.period.toString() == p) return;
                changePeriod(p, assetCubit);
              },
              child: Container(
                height: 20,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5.0),
                  color: assetCubit.period.toString() == p ? Colors.red : Colors.white,
                ),
                child: Center(
                  child: Text(p, style: const TextStyle(fontSize: 10)),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void setPeriod(String period) {}
}