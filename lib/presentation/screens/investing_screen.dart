import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/presentation/widgets/all.dart';

class InvestingScreen extends StatefulWidget {
  final String title;

  const InvestingScreen({Key? key, required this.title}) : super(key: key);

  @override
  _InvestingScreenState createState() => _InvestingScreenState();
}

GlobalKey<SfCircularChartState> _chartKey = GlobalKey<SfCircularChartState>();

class _InvestingScreenState extends State<InvestingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Investment> _chartData;
  int? _selectedSliceIndex;

  @override
  void initState() {
    _chartData = _createData();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Investment> _createData() {
    return [
      Investment('Stocks & Options', 60, 1),
      Investment('Cryptocurrencies', 30, 1),
      Investment('Brokerage Cash', 10, 1),
    ];
  }

  Color _getSliceColor(int index) {
    if (_selectedSliceIndex != null && _selectedSliceIndex == index) {
      // Darken the selected slice
      return Colors.blue.shade900;
    } else {
      // Lighten the other slices
      return Colors.blue.shade200;
    }
  }
  final List<Color> sliceColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SummaryTable(
          title: 'Stocks & Options',
          categories: ['Stocks & Options', 'Cryptocurrencies', 'Brokerage Cash'],
          percentages: [60, 30, 10],
          totalAmounts: ['\$60,000', '\$30,000', '\$10,000'],
          onCategoryTap: (int index) {
            setState(() {
              print(' hello $index');
              _selectedSliceIndex = index;
            });
          },
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: _animationController,
                curve: Interval(0.0, 1.0),
              ),
              child: SfCircularChart(
                key: _chartKey,
                series: [
                  PieSeries<Data, String>(
                    onPointTap: (ChartPointDetails details) {
                      print(details.pointIndex);
                    },
                    dataSource: [
                      Data('Stocks & Options', 30, 0),
                      Data('Cryptocurrencies', 20, 1),
                      Data('Brokerage Cash', 50, 2),
                    ],
                    xValueMapper: (Data data, _) => data.category,
                    yValueMapper: (Data data, _) => data.percentage,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    enableTooltip: true,
                    pointColorMapper: (Data data, _) => sliceColors[data.index]
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Investment {
  final String category;
  final double percentage;
  final int index;

  Investment(this.category, this.percentage, this.index);
}

class Data {
  final String category;
  final double percentage;
  final int index;

  Data(this.category, this.percentage, this.index);
}
