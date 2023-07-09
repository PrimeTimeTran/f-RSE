// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'candlestick.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CandleStick _$CandleStickFromJson(Map<String, dynamic> json) {
  return _CandleStick.fromJson(json);
}

/// @nodoc
mixin _$CandleStick {
  double get l => throw _privateConstructorUsedError;
  double get o => throw _privateConstructorUsedError;
  double get h => throw _privateConstructorUsedError;
  double get c => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CandleStickCopyWith<CandleStick> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CandleStickCopyWith<$Res> {
  factory $CandleStickCopyWith(
          CandleStick value, $Res Function(CandleStick) then) =
      _$CandleStickCopyWithImpl<$Res, CandleStick>;
  @useResult
  $Res call({double l, double o, double h, double c, String time});
}

/// @nodoc
class _$CandleStickCopyWithImpl<$Res, $Val extends CandleStick>
    implements $CandleStickCopyWith<$Res> {
  _$CandleStickCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? l = null,
    Object? o = null,
    Object? h = null,
    Object? c = null,
    Object? time = null,
  }) {
    return _then(_value.copyWith(
      l: null == l
          ? _value.l
          : l // ignore: cast_nullable_to_non_nullable
              as double,
      o: null == o
          ? _value.o
          : o // ignore: cast_nullable_to_non_nullable
              as double,
      h: null == h
          ? _value.h
          : h // ignore: cast_nullable_to_non_nullable
              as double,
      c: null == c
          ? _value.c
          : c // ignore: cast_nullable_to_non_nullable
              as double,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CandleStickCopyWith<$Res>
    implements $CandleStickCopyWith<$Res> {
  factory _$$_CandleStickCopyWith(
          _$_CandleStick value, $Res Function(_$_CandleStick) then) =
      __$$_CandleStickCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double l, double o, double h, double c, String time});
}

/// @nodoc
class __$$_CandleStickCopyWithImpl<$Res>
    extends _$CandleStickCopyWithImpl<$Res, _$_CandleStick>
    implements _$$_CandleStickCopyWith<$Res> {
  __$$_CandleStickCopyWithImpl(
      _$_CandleStick _value, $Res Function(_$_CandleStick) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? l = null,
    Object? o = null,
    Object? h = null,
    Object? c = null,
    Object? time = null,
  }) {
    return _then(_$_CandleStick(
      l: null == l
          ? _value.l
          : l // ignore: cast_nullable_to_non_nullable
              as double,
      o: null == o
          ? _value.o
          : o // ignore: cast_nullable_to_non_nullable
              as double,
      h: null == h
          ? _value.h
          : h // ignore: cast_nullable_to_non_nullable
              as double,
      c: null == c
          ? _value.c
          : c // ignore: cast_nullable_to_non_nullable
              as double,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CandleStick implements _CandleStick {
  _$_CandleStick(
      {required this.l,
      required this.o,
      required this.h,
      required this.c,
      required this.time});

  factory _$_CandleStick.fromJson(Map<String, dynamic> json) =>
      _$$_CandleStickFromJson(json);

  @override
  final double l;
  @override
  final double o;
  @override
  final double h;
  @override
  final double c;
  @override
  final String time;

  @override
  String toString() {
    return 'CandleStick(l: $l, o: $o, h: $h, c: $c, time: $time)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CandleStick &&
            (identical(other.l, l) || other.l == l) &&
            (identical(other.o, o) || other.o == o) &&
            (identical(other.h, h) || other.h == h) &&
            (identical(other.c, c) || other.c == c) &&
            (identical(other.time, time) || other.time == time));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, l, o, h, c, time);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CandleStickCopyWith<_$_CandleStick> get copyWith =>
      __$$_CandleStickCopyWithImpl<_$_CandleStick>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CandleStickToJson(
      this,
    );
  }
}

abstract class _CandleStick implements CandleStick {
  factory _CandleStick(
      {required final double l,
      required final double o,
      required final double h,
      required final double c,
      required final String time}) = _$_CandleStick;

  factory _CandleStick.fromJson(Map<String, dynamic> json) =
      _$_CandleStick.fromJson;

  @override
  double get l;
  @override
  double get o;
  @override
  double get h;
  @override
  double get c;
  @override
  String get time;
  @override
  @JsonKey(ignore: true)
  _$$_CandleStickCopyWith<_$_CandleStick> get copyWith =>
      throw _privateConstructorUsedError;
}
