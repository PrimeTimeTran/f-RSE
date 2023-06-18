import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/cubits/all.dart';

class PeriodSelector extends StatelessWidget {
  final List<String> periods = ['live', '1d', '1w', '1m', '3m', '1y'];

  PeriodSelector({super.key});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: periods.map((p) {
          return Flexible(
            fit: FlexFit.tight,
            child: BlocConsumer<AssetCubit, AssetState>(
              builder: (c, state) {
                if (state is AssetLoaded) {
                  final assetCubit = BlocProvider.of<AssetCubit>(context);
                  return GestureDetector(
                    onTap: () {
                      assetCubit.setPeriod(p);
                    },
                    child: Container(
                      height: 20, // Adjust the height as needed
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5.0),
                        color: assetCubit.period == p ? Colors.red : Colors.white,
                      ),
                      child: Center(
                        child: Text(p, style: const TextStyle(fontSize: 10)),
                      ),
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
    );
  }

  void setPeriod(String period) {}
}