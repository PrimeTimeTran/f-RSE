import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rse/data/cubits/all.dart';

import 'package:rse/presentation/widgets/all.dart';

class AssetScreen extends StatefulWidget {
  const AssetScreen({super.key});

  @override
  State<AssetScreen> createState() => _AssetScreeState();
}

class _AssetScreeState extends State<AssetScreen> {
  late AssetCubit _assetCubit;

  @override
  void initState() {
    super.initState();
    _assetCubit = context.read<AssetCubit>();
    fetchData();
  }

  Future<void> fetchData() async {
    _assetCubit.fetchAsset("1");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
      child: Column(
        children: [
          BlocConsumer<AssetCubit, AssetState>(
            builder: (context, state) {
              if (state is AssetLoading) {
                return const CircularProgressIndicator();
              } else if (state is AssetLoaded) {
                final data = context.read<AssetCubit>().current;
                return CandleStickChart(data: data);
              } else if (state is AssetError) {
                return Text('Error: ${state.errorMessage}');
              } else {
                return const Text('Unknown state');
              }
            },
            listener: (context, state) {
            },
            buildWhen: (previous, current) {
              return true;
            },
          ),
        ],
      ),
    ));
  }
}
