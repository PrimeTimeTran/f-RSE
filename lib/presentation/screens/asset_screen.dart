import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/all.dart';
import 'package:rse/presentation/all.dart';

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

  getPadding(context) {
    if (isS(context)) {
      return const EdgeInsets.symmetric(horizontal: 60);
    }
    if (isM(context)) {
      return const EdgeInsets.symmetric(horizontal: 10);
    }
    return const EdgeInsets.symmetric(horizontal: 10);
  }

  Widget buildTwoColumn() {
    return Padding(
      padding: getPadding(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: const SingleChildScrollView(
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
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Text(''),
            ),
          )
        ],
      ),
    );
  }
}
