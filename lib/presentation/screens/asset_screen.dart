import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:rse/all.dart';

class AssetScreen extends StatefulWidget {
  final String sym;
  const AssetScreen({super.key, required this.sym});

  @override
  State<AssetScreen> createState() => _AssetScreeState();
}

class _AssetScreeState extends State<AssetScreen> {
  static const _actionTitles = ['Options', 'Sell', 'Buy'];

  @override
  void initState() {
    super.initState();
    setScreenName('securities/${widget.sym}');
  }

  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(_actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobile: buildOneColumn(context),
        desktop: buildTwoColumn(),
      ),
      floatingActionButton: _getFAB(context),
    );
  }

  Widget _getFAB(context) {
    if (isS(context)) {
      return ExpandableFab(
        sym: widget.sym,
        distance: 112,
        children: [
          ActionButton(
            title: 'Options',
            icon: const Icon(Icons.add_chart),
            onPressed: () => _showAction(context, 0),
          ),
          ActionButton(
            title: 'Sell',
            icon: const Icon(Icons.sell),
            onPressed: () => _showAction(context, 1),
          ),
          ActionButton(
            title: 'Buy',
            icon: const Icon(Icons.add),
            onPressed: () => _showAction(context, 2),
          ),
        ],
      );
    }
    return Container();
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
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: T(context, 'outline'),)
                ),
                child: const OrderPanel(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
