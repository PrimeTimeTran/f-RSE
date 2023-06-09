import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/blocs/all.dart';
import 'package:rse/common/widgets/all.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PortfolioBloc _portfolioBloc;

  @override
  void initState() {
    super.initState();
    _portfolioBloc = BlocProvider.of<PortfolioBloc>(context);
    fetchData();
  }

  Future<void> fetchData() async {
    _portfolioBloc.add(FetchPortfolio("1"));
  }

  @override
  void dispose() {
    _portfolioBloc.close();
    super.dispose();
  }

  List<OptionData> optionsData = [
    OptionData(
      delta: 0.5,
      volume: 100,
      bid: 10.0,
      ask: 12.0,
      askIv: 0.8,
      strike: 100.0,
      bidIv: 0.9,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          BlocConsumer<PortfolioBloc, PortfolioState>(
            builder: (c, s) {
              if (s is PortfolioLoading) {
                return const CircularProgressIndicator();
              } else if (s is PortfolioLoaded) {
                final dataPoints = _portfolioBloc.getDataPoints();
                return Column(
                  children: [
                    LineChart(data: dataPoints),
                    CandleStickChart(data: s.portfolio.series)
                  ],
                );
              } else if (s is PortfolioError) {
                return Text('Error: ${s.errorMessage}');
              } else {
                return const Text('Unknown state');
              }
            },
            listener: (c, s) {
            },
            buildWhen: (previous, current) {
              return true;
            },
          ),
          OptionsTable(optionsData: optionsData),
        ],
      ),
    );
  }
}

