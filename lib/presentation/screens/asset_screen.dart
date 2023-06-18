import 'package:flutter/material.dart';

import 'package:rse/presentation/widgets/all.dart';

class AssetScreen extends StatefulWidget {
  const AssetScreen({super.key});

  @override
  State<AssetScreen> createState() => _AssetScreeState();
}

class _AssetScreeState extends State<AssetScreen> {

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        child: Column(
          children: [
            CandleChart(),
            AssetOverview(),
          ],
        )
    );
  }
}
