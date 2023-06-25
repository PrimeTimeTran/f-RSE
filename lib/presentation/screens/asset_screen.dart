import 'package:flutter/material.dart';
import 'package:rse/all.dart';

class AssetScreen extends StatefulWidget {
  final String sym;
  const AssetScreen({super.key, required this.sym});

  @override
  State<AssetScreen> createState() => _AssetScreeState();
}

class _AssetScreeState extends State<AssetScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobile: buildOneColumn(context),
        desktop: buildTwoColumn(),
      ),
    );
  }

  Widget buildOneColumn(context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          CandleChart(),
          AssetOverview(),
        ],
      ),
    );
  }

  Widget buildTwoColumn() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: const SingleChildScrollView(
              child: Column(
                children: [
                  CandleChart(),
                  AssetOverview(),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black)
              ),
              child: const Column(
                  children: [
                    Text('soso'),
                  ]
              ),
            ),
          ),
        ),
      ],
    );
  }
}
