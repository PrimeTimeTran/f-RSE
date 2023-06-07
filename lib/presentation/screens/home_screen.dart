import 'package:flutter/material.dart';
import 'package:rse/common/widgets/candlestick.dart';
import 'package:rse/common/widgets/options_chain.dart';

import 'package:rse/data/models/candlestick_data.dart';

import 'package:rse/services/portfolio_service.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CandleStickData>? stockDataList;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final service = PortfolioService();
    final data = await service.fetchValues();
    setState(() {
      stockDataList = data;
    });
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
    )

    // Add more OptionData objects as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          if (stockDataList != null)
            CandlestickChartExample(stockData: stockDataList!),
          OptionsTable(optionsData: optionsData),
        ],
      ),
    );
  }
}
