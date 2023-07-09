// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'asset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Asset {
  String? get name => throw _privateConstructorUsedError;
  double get o => throw _privateConstructorUsedError;
  Meta get meta => throw _privateConstructorUsedError;
  String get sym => throw _privateConstructorUsedError;
  Company get company => throw _privateConstructorUsedError;
  List<CandleStick> get current => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AssetCopyWith<Asset> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssetCopyWith<$Res> {
  factory $AssetCopyWith(Asset value, $Res Function(Asset) then) =
      _$AssetCopyWithImpl<$Res, Asset>;
  @useResult
  $Res call(
      {String? name,
      double o,
      Meta meta,
      String sym,
      Company company,
      List<CandleStick> current});

  $MetaCopyWith<$Res> get meta;
  $CompanyCopyWith<$Res> get company;
}

/// @nodoc
class _$AssetCopyWithImpl<$Res, $Val extends Asset>
    implements $AssetCopyWith<$Res> {
  _$AssetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? o = null,
    Object? meta = null,
    Object? sym = null,
    Object? company = null,
    Object? current = null,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      o: null == o
          ? _value.o
          : o // ignore: cast_nullable_to_non_nullable
              as double,
      meta: null == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as Meta,
      sym: null == sym
          ? _value.sym
          : sym // ignore: cast_nullable_to_non_nullable
              as String,
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as Company,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as List<CandleStick>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MetaCopyWith<$Res> get meta {
    return $MetaCopyWith<$Res>(_value.meta, (value) {
      return _then(_value.copyWith(meta: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CompanyCopyWith<$Res> get company {
    return $CompanyCopyWith<$Res>(_value.company, (value) {
      return _then(_value.copyWith(company: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AssetCopyWith<$Res> implements $AssetCopyWith<$Res> {
  factory _$$_AssetCopyWith(_$_Asset value, $Res Function(_$_Asset) then) =
      __$$_AssetCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      double o,
      Meta meta,
      String sym,
      Company company,
      List<CandleStick> current});

  @override
  $MetaCopyWith<$Res> get meta;
  @override
  $CompanyCopyWith<$Res> get company;
}

/// @nodoc
class __$$_AssetCopyWithImpl<$Res> extends _$AssetCopyWithImpl<$Res, _$_Asset>
    implements _$$_AssetCopyWith<$Res> {
  __$$_AssetCopyWithImpl(_$_Asset _value, $Res Function(_$_Asset) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? o = null,
    Object? meta = null,
    Object? sym = null,
    Object? company = null,
    Object? current = null,
  }) {
    return _then(_$_Asset(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      o: null == o
          ? _value.o
          : o // ignore: cast_nullable_to_non_nullable
              as double,
      meta: null == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as Meta,
      sym: null == sym
          ? _value.sym
          : sym // ignore: cast_nullable_to_non_nullable
              as String,
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as Company,
      current: null == current
          ? _value._current
          : current // ignore: cast_nullable_to_non_nullable
              as List<CandleStick>,
    ));
  }
}

/// @nodoc

class _$_Asset implements _Asset {
  _$_Asset(
      {this.name,
      required this.o,
      required this.meta,
      required this.sym,
      required this.company,
      required final List<CandleStick> current})
      : _current = current;

  @override
  final String? name;
  @override
  final double o;
  @override
  final Meta meta;
  @override
  final String sym;
  @override
  final Company company;
  final List<CandleStick> _current;
  @override
  List<CandleStick> get current {
    if (_current is EqualUnmodifiableListView) return _current;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_current);
  }

  @override
  String toString() {
    return 'Asset(name: $name, o: $o, meta: $meta, sym: $sym, company: $company, current: $current)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Asset &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.o, o) || other.o == o) &&
            (identical(other.meta, meta) || other.meta == meta) &&
            (identical(other.sym, sym) || other.sym == sym) &&
            (identical(other.company, company) || other.company == company) &&
            const DeepCollectionEquality().equals(other._current, _current));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, o, meta, sym, company,
      const DeepCollectionEquality().hash(_current));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AssetCopyWith<_$_Asset> get copyWith =>
      __$$_AssetCopyWithImpl<_$_Asset>(this, _$identity);
}

abstract class _Asset implements Asset {
  factory _Asset(
      {final String? name,
      required final double o,
      required final Meta meta,
      required final String sym,
      required final Company company,
      required final List<CandleStick> current}) = _$_Asset;

  @override
  String? get name;
  @override
  double get o;
  @override
  Meta get meta;
  @override
  String get sym;
  @override
  Company get company;
  @override
  List<CandleStick> get current;
  @override
  @JsonKey(ignore: true)
  _$$_AssetCopyWith<_$_Asset> get copyWith =>
      throw _privateConstructorUsedError;
}
