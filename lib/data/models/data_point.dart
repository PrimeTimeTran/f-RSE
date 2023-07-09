import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_point.freezed.dart';

@freezed
class DataPoint with _$DataPoint {
  factory DataPoint(
      String x,
      double y,
      ) = _DataPoint;

  factory DataPoint.defaultDataPoint() => DataPoint(
    '',
    0,
  );
}
