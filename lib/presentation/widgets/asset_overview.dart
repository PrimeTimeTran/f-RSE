import 'package:flutter/material.dart';

import 'package:rse/presentation/all.dart';

class AssetOverview extends StatelessWidget {
  const AssetOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          HoverDarken(child: YourPosition()),
          UpcomingActivity(),
          HoverDarken(child: About()),
          HoverDarken(child: KeyStatistics()),
          HoverDarken(child: AssetActivityHistory()),
        ]
      ),
    );
  }
}
