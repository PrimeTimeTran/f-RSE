import 'package:flutter/material.dart';

import 'package:rse/common/widgets/chart.dart';

class HomeScreen extends StatelessWidget {
  final String title;

  const HomeScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StockChart(),
    );
  }
}
