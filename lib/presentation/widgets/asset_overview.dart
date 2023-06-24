import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

import 'package:rse/presentation/all.dart';

class AssetOverview extends StatelessWidget {
  const AssetOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          HoverDarken(child: YourPosition(), addPadding: true),
          UpcomingActivity(),
          HoverDarken(child: About(), addPadding: true),
          HoverDarken(child: KeyStatistics(), addPadding: true),
          HoverDarken(child: AssetActivityHistory(), addPadding: true),
        ]
      ),
    );
  }
}
