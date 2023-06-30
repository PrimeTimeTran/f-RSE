abstract class Point {
  final String x;
  final double y;
  Point(this.x, this.y);
}

class Chart {
  late String sym = 'BAC';
  late String time = '';
  late double xOffSet = 0;
  late String type = 'line';
  late double startValue = 1;
  late double latestValue = 1;
  late String period = 'live';
  late double focusedValue = 1;
  late double portfolioStartValue = 1;
  late List<CandleStick> candleSeries = [];
  late CandleStick candle = CandleStick.fact();
  late List<DataPoint> data = [DataPoint(DateTime.now().toString(), 1)];

  Chart();

  Chart copyWith({
    String? type,
    String? time,
    String? period,
    String sym = '',
    double? xOffSet,
    double? startValue,
    double? latestValue,
    CandleStick? candle,
    double? focusedValue,
    List<DataPoint>? data,
    double? portfolioStartValue,
    List<CandleStick>? candleSeries,
  }) {
    var temp = sym == '' ? this.sym : sym;
    return Chart()
      ..sym = temp
      ..type = type ?? this.type
      ..time = time ?? this.time
      ..candle = candle ?? this.candle
      ..period = period ?? this.period
      ..xOffSet = xOffSet ?? this.xOffSet
      ..data = List.from(data ?? this.data)
      ..startValue = startValue ?? this.startValue
      ..latestValue = latestValue ?? this.latestValue
      ..focusedValue = focusedValue ?? this.focusedValue
      ..candleSeries = List.from(candleSeries ?? this.candleSeries)
      ..portfolioStartValue = portfolioStartValue ?? this.portfolioStartValue;
  }
}

class CandleStick extends Point{
  final double low;
  final String time;
  final double open;
  final double high;
  final double close;
  final double value;

  CandleStick({
    required this.low,
    required this.open,
    required this.high,
    required this.close,
    required this.value,
    required this.time,
    String x = '',
    double y = 0,
  }) : super(x, y);

  factory CandleStick.fromJson(Map<String, dynamic> j) => CandleStick(
    low: j['l'],
    open: j['o'],
    high: j['h'],
    close: j['c'],
    time: j['time'],
    value: j['c'] ?? j['value'],
  );

  @override
  String toString() {
    return 'CandleStick { '
      'low: $low, '
      'time: $time, '
      'open: $open, '
      'high: $high, '
      'value: $value, '
      'close: $close, '
      '}';
  }

  factory CandleStick.fact() => CandleStick(
    low: 0,
    open: 0,
    high: 0,
    close: 0,
    value: 0,
    time: DateTime.now().toIso8601String(),
  );

  CandleStick copyWith({
    double? low,
    String? time,
    double? open,
    double? high,
    double? close,
    double? value,
  }) {
    return CandleStick(
      low: low ?? this.low,
      time: time ?? this.time,
      open: open ?? this.open,
      high: high ?? this.high,
      close: close ?? this.close,
      value: value ?? this.value,
    );
  }
}

class DataPoint extends Point {
  final String x;
  final double y;

  DataPoint(this.x, this.y) : super(x, y);
  factory DataPoint.fact() => DataPoint(
      DateTime.now().toIso8601String(),
      0,
    );
}
