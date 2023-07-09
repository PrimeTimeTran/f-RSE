// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DataPoint {
  String get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DataPointCopyWith<DataPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataPointCopyWith<$Res> {
  factory $DataPointCopyWith(DataPoint value, $Res Function(DataPoint) then) =
      _$DataPointCopyWithImpl<$Res, DataPoint>;
  @useResult
  $Res call({String x, double y});
}

/// @nodoc
class _$DataPointCopyWithImpl<$Res, $Val extends DataPoint>
    implements $DataPointCopyWith<$Res> {
  _$DataPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_value.copyWith(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as String,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DataPointCopyWith<$Res> implements $DataPointCopyWith<$Res> {
  factory _$$_DataPointCopyWith(
          _$_DataPoint value, $Res Function(_$_DataPoint) then) =
      __$$_DataPointCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String x, double y});
}

/// @nodoc
class __$$_DataPointCopyWithImpl<$Res>
    extends _$DataPointCopyWithImpl<$Res, _$_DataPoint>
    implements _$$_DataPointCopyWith<$Res> {
  __$$_DataPointCopyWithImpl(
      _$_DataPoint _value, $Res Function(_$_DataPoint) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_$_DataPoint(
      null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as String,
      null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$_DataPoint implements _DataPoint {
  _$_DataPoint(this.x, this.y);

  @override
  final String x;
  @override
  final double y;

  @override
  String toString() {
    return 'DataPoint(x: $x, y: $y)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DataPoint &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y));
  }

  @override
  int get hashCode => Object.hash(runtimeType, x, y);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DataPointCopyWith<_$_DataPoint> get copyWith =>
      __$$_DataPointCopyWithImpl<_$_DataPoint>(this, _$identity);
}

abstract class _DataPoint implements DataPoint {
  factory _DataPoint(final String x, final double y) = _$_DataPoint;

  @override
  String get x;
  @override
  double get y;
  @override
  @JsonKey(ignore: true)
  _$$_DataPointCopyWith<_$_DataPoint> get copyWith =>
      throw _privateConstructorUsedError;
}
