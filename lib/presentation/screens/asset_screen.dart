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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            return buildSingleColumnLayout(context);
          } else {
            return buildTwoColumnLayout();
          }
        },
      ),
    );
  }

  Widget buildSingleColumnLayout(context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          CandleChart(),
          AssetOverview(),
        ],
      ),
    );
  }

  Widget buildTwoColumnLayout() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CandleChart(),
                  AssetOverview(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Text('sksisis'),
            ),
          )
        ],
      ),
    );
  }
}
