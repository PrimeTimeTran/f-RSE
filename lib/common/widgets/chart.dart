import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class StockChart extends StatefulWidget {
  const StockChart({super.key});

  @override
  _StockChartState createState() => _StockChartState();
}

class _StockChartState extends State<StockChart> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('https://localhost:7254/prices'));
      if (response.statusCode == 200) {
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(),
        series: <ChartSeries>[
          CandleSeries<StockData, DateTime>(
            dataSource: <StockData>[
              StockData(
                DateTime(2022, 1, 1),
                150.0,
                200.0,
                125.0,
                175.0,
              ),
              StockData(
                DateTime(2022, 1, 2),
                175.0,
                250.0,
                150.0,
                225.0,
              ),
              StockData(
                DateTime(2022, 1, 3),
                225.0,
                275.0,
                200.0,
                250.0,
              ),
              StockData(
                DateTime(2022, 1, 4),
                250.0,
                300.0,
                225.0,
                275.0,
              ),
              StockData(
                DateTime(2022, 1, 5),
                275.0,
                350.0,
                250.0,
                325.0,
              ),
              StockData(
                DateTime(2022, 1, 6),
                325.0,
                400.0,
                300.0,
                375.0,
              ),
            ],
            xValueMapper: (StockData stock, _) => stock.date,
            lowValueMapper: (StockData stock, _) => stock.low,
            highValueMapper: (StockData stock, _) => stock.high,
            openValueMapper: (StockData stock, _) => stock.open,
            closeValueMapper: (StockData stock, _) => stock.close,
          ),
        ],
      ),
    );
  }
}

class StockData {
  final DateTime date;
  final double low;
  final double high;
  final double open;
  final double close;

  StockData(this.date, this.low, this.high, this.open, this.close);
}
