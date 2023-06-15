import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/cubits/all.dart';
import 'package:rse/presentation/widgets/all.dart';

class PortfolioLineChart extends StatelessWidget {
  const PortfolioLineChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PortfolioCubit, PortfolioState>(
      builder: (context, state) {
        if (state is PortfolioLoading) {
          return const CircularProgressIndicator();
        } else if (state is PortfolioLoaded) {
          final dataPoints = context.read<PortfolioCubit>().dataPoints;
          return LineChart(data: dataPoints);
        } else if (state is PortfolioError) {
          return Text('Error: ${state.errorMessage}');
        } else {
          return const Text('Unknown state');
        }
      },
      listener: (context, state) {
        // Listener logic goes here if needed
      },
      buildWhen: (previous, current) {
        return true;
      },
    );
  }
}
