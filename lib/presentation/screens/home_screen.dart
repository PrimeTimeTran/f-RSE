import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rse/data/all.dart';
import 'package:rse/presentation/all.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.label, Key? key})
      : super(key: key);

  final String label;

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final p = context.read<PortfolioCubit>();
    context.read<ChartCubit>().initialChartLoad(p.startValue, p.currentValue);
    return Scaffold(
      body: ResponsiveLayout(
        mobile: buildMobile(context),
        desktop: buildDesktop(context),
      ),
    );
  }

  Widget buildMobile(context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          LineChart(),
          Articles(),
        ],
      ),
    );
  }

  Widget buildDesktop(context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: const SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(right: 35, left: 20),
                  child: Column(
                    children: [
                      TickerCarousel(),
                      LineChart(),
                      Articles(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Watchlist(),
        ],
      ),
    );
  }
}


