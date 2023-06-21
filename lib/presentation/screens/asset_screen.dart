import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/all.dart';
import 'package:rse/presentation/widgets/all.dart';

class AssetScreen extends StatefulWidget {
  final String sym;
  const AssetScreen({super.key, required this.sym});

  @override
  State<AssetScreen> createState() => _AssetScreeState();
}

class _AssetScreeState extends State<AssetScreen> {
  late AssetCubit _assetCubit;

  @override
  void initState() {
    super.initState();
    _assetCubit = context.read<AssetCubit>();
    _assetCubit.fetchAsset(widget.sym);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            return buildOneColumn(context);
          } else {
            return buildTwoColumn();
          }
        },
      ),
    );
  }

  Widget buildOneColumn(context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          CandleChart(),
          AssetOverview(),
          AssetOverview(),
          AssetOverview(),
          AssetOverview(),
          AssetOverview(),
          AssetOverview(),
          AssetOverview(),
        ],
      ),
    );
  }

  Widget buildTwoColumn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 60),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.sym),
          const Expanded(
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
          const Expanded(
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
