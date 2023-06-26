import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/all.dart';

class AssetOverview extends StatelessWidget {
  const AssetOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetBloc, AssetState>(
      builder: (context, state) {
        if (state is AssetLoaded) {
          final asset = state.asset;
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
                children: [
                  HoverDarken(child: YourPosition()),
                  UpcomingActivity(),
                  HoverDarken(child: About(asset: asset)),
                  HoverDarken(child: KeyStatistics(asset: asset)),
                  HoverDarken(child: AssetActivityHistory(asset: asset)),
                ]
            ),
          );
        } else {
          return const SizedBox();
        }
      }
    );
  }
}
