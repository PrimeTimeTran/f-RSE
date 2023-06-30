class Chart {
  String time = '';
  String sym = 'BAC';
  double xOffSet = 0;
  String type = 'line';
  double startValue = 1;
  double latestValue = 1;
  String period = 'live';
  double focusedValue = 1;
  List<CandleStick> candleSeries = [];
  CandleStick candle = CandleStick.fact();
  List<DataPoint> data = [DataPoint(DateTime.now().toString(), 1)];

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
      ..candleSeries = List.from(candleSeries ?? this.candleSeries);
  }
}

class CandleStick {
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
  });

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

class DataPoint {
  final String x;
  final double y;
  DataPoint(
    this.x,
    this.y
  );

  factory DataPoint.fact() => DataPoint(
    DateTime.now().toIso8601String(),
    0,
  );
}