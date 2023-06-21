class Chart {
  late double xOffSet;
  late CandleStick hoveredCandle;
  late List<CandleStick> data = [];

  Chart(this.xOffSet, this.hoveredCandle, this.data);

  factory Chart.defaultChart() => Chart(
    0,
    CandleStick.fact(),
    [],
  );

  Chart copyWith({
    double? xOffSet,
    CandleStick? hoveredCandle,
    List<CandleStick>? data,
  }) {
    return Chart(
      xOffSet ?? this.xOffSet,
      hoveredCandle ?? this.hoveredCandle,
      data ?? this.data,
    );
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
    time: '',
    value: 0,
  );
}

class DataPoint {
  final String x;
  final double y;

  DataPoint(this.x, this.y);
}
