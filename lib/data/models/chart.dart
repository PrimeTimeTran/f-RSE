abstract class Point {
  final String x;
  final double y;
  Point(this.x, this.y);
}

class Chart {
  late String sym = '';
  late String time = '';
  late double xOffSet = 0;
  late String type = 'line';
  late double startValue = 0;
  late double latestValue = 0;
  late String period = 'live';
  late double portfolioStartValue = 0;
  late List<CandleStick> candleSeries = [];
  late CandleStick candle = CandleStick.fact();
  late DataPoint focusedPoint = DataPoint('', 0);
  late List<DataPoint> data = [DataPoint(DateTime.now().toString(), 0)];

  Chart();

  Chart copyWith({
    String? type,
    String? time,
    String? period,
    double? xOffSet,
    String sym = '',
    double? startValue,
    CandleStick? candle,
    double? latestValue,
    List<DataPoint>? data,
    DataPoint? focusedPoint,
    List<CandleStick>? candleSeries,
    double? portfolioStartValue,
  }) {
    return Chart()
      ..sym = sym ?? this.sym
      ..type = type ?? this.type
      ..time = time ?? this.time
      ..candle = candle ?? this.candle
      ..period = period ?? this.period
      ..xOffSet = xOffSet ?? this.xOffSet
      ..data = List.from(data ?? this.data)
      ..startValue = startValue ?? this.startValue
      ..latestValue = latestValue ?? this.latestValue
      ..focusedPoint = focusedPoint ?? this.focusedPoint
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
    time: '',
    value: 0,
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
