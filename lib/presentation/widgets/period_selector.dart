import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/cubits/all.dart';

class PeriodSelector extends StatelessWidget {
  final List<String> periods;

  const PeriodSelector({super.key, required this.periods });

  @override
  Widget build(BuildContext context) {
    final assetCubit = BlocProvider.of<AssetCubit>(context);
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: periods.map((period) {
          return Flexible(
            fit: FlexFit.tight,
            child: GestureDetector(
              onTap: () {
                assetCubit.setPeriod(period);
              },
              child: Container(
                height: 20, // Adjust the height as needed
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5.0),
                  color: assetCubit.period.toString() == period ? Colors.red : Colors.white,
                ),
                child: Center(
                  child: Text(period, style: const TextStyle(fontSize: 10)),
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