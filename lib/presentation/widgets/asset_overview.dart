import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

import 'package:rse/presentation/all.dart';

class AssetOverview extends StatelessWidget {
  const AssetOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          HoverDarken(child: YourPosition(), padding: true),
          UpcomingActivity(),
          HoverDarken(child: About(), padding: true),
          HoverDarken(child: KeyStatistics(), padding: true),
          HoverDarken(child: AssetActivityHistory(), padding: true),
        ]
      ),
    );
  }
}
