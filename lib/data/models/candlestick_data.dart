class CandleStickData {
  final String date;
  final double open;
  final double high;
  final double low;
  final double close;

  CandleStickData({
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  factory CandleStickData.fromJson(Map<String, dynamic> json) {
    return CandleStickData(
      date: json['dateOfAggregation'] as String,
      open: json['o'] as double,
      high: json['h'] as double,
      low: json['l'] as double,
      close: json['c'] as double,
    );
  }
}
