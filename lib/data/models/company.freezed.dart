// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Company _$CompanyFromJson(Map<String, dynamic> json) {
  return _Company.fromJson(json);
}

/// @nodoc
mixin _$Company {
  int get id => throw _privateConstructorUsedError;
  int get ec => throw _privateConstructorUsedError;
  String get hq => throw _privateConstructorUsedError;
  String get eh => throw _privateConstructorUsedError;
  String get sym => throw _privateConstructorUsedError;
  DateTime get f => throw _privateConstructorUsedError;
  String get ceo => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get industry => throw _privateConstructorUsedError;
  String get desc => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompanyCopyWith<Company> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyCopyWith<$Res> {
  factory $CompanyCopyWith(Company value, $Res Function(Company) then) =
      _$CompanyCopyWithImpl<$Res, Company>;
  @useResult
  $Res call(
      {int id,
      int ec,
      String hq,
      String eh,
      String sym,
      DateTime f,
      String ceo,
      String name,
      String industry,
      String desc});
}

/// @nodoc
class _$CompanyCopyWithImpl<$Res, $Val extends Company>
    implements $CompanyCopyWith<$Res> {
  _$CompanyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ec = null,
    Object? hq = null,
    Object? eh = null,
    Object? sym = null,
    Object? f = null,
    Object? ceo = null,
    Object? name = null,
    Object? industry = null,
    Object? desc = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      ec: null == ec
          ? _value.ec
          : ec // ignore: cast_nullable_to_non_nullable
              as int,
      hq: null == hq
          ? _value.hq
          : hq // ignore: cast_nullable_to_non_nullable
              as String,
      eh: null == eh
          ? _value.eh
          : eh // ignore: cast_nullable_to_non_nullable
              as String,
      sym: null == sym
          ? _value.sym
          : sym // ignore: cast_nullable_to_non_nullable
              as String,
      f: null == f
          ? _value.f
          : f // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ceo: null == ceo
          ? _value.ceo
          : ceo // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      industry: null == industry
          ? _value.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CompanyCopyWith<$Res> implements $CompanyCopyWith<$Res> {
  factory _$$_CompanyCopyWith(
          _$_Company value, $Res Function(_$_Company) then) =
      __$$_CompanyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int ec,
      String hq,
      String eh,
      String sym,
      DateTime f,
      String ceo,
      String name,
      String industry,
      String desc});
}

/// @nodoc
class __$$_CompanyCopyWithImpl<$Res>
    extends _$CompanyCopyWithImpl<$Res, _$_Company>
    implements _$$_CompanyCopyWith<$Res> {
  __$$_CompanyCopyWithImpl(_$_Company _value, $Res Function(_$_Company) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ec = null,
    Object? hq = null,
    Object? eh = null,
    Object? sym = null,
    Object? f = null,
    Object? ceo = null,
    Object? name = null,
    Object? industry = null,
    Object? desc = null,
  }) {
    return _then(_$_Company(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      ec: null == ec
          ? _value.ec
          : ec // ignore: cast_nullable_to_non_nullable
              as int,
      hq: null == hq
          ? _value.hq
          : hq // ignore: cast_nullable_to_non_nullable
              as String,
      eh: null == eh
          ? _value.eh
          : eh // ignore: cast_nullable_to_non_nullable
              as String,
      sym: null == sym
          ? _value.sym
          : sym // ignore: cast_nullable_to_non_nullable
              as String,
      f: null == f
          ? _value.f
          : f // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ceo: null == ceo
          ? _value.ceo
          : ceo // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      industry: null == industry
          ? _value.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Company implements _Company {
  _$_Company(
      {required this.id,
      required this.ec,
      required this.hq,
      required this.eh,
      required this.sym,
      required this.f,
      required this.ceo,
      required this.name,
      required this.industry,
      required this.desc});

  factory _$_Company.fromJson(Map<String, dynamic> json) =>
      _$$_CompanyFromJson(json);

  @override
  final int id;
  @override
  final int ec;
  @override
  final String hq;
  @override
  final String eh;
  @override
  final String sym;
  @override
  final DateTime f;
  @override
  final String ceo;
  @override
  final String name;
  @override
  final String industry;
  @override
  final String desc;

  @override
  String toString() {
    return 'Company(id: $id, ec: $ec, hq: $hq, eh: $eh, sym: $sym, f: $f, ceo: $ceo, name: $name, industry: $industry, desc: $desc)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Company &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ec, ec) || other.ec == ec) &&
            (identical(other.hq, hq) || other.hq == hq) &&
            (identical(other.eh, eh) || other.eh == eh) &&
            (identical(other.sym, sym) || other.sym == sym) &&
            (identical(other.f, f) || other.f == f) &&
            (identical(other.ceo, ceo) || other.ceo == ceo) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.industry, industry) ||
                other.industry == industry) &&
            (identical(other.desc, desc) || other.desc == desc));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, ec, hq, eh, sym, f, ceo, name, industry, desc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CompanyCopyWith<_$_Company> get copyWith =>
      __$$_CompanyCopyWithImpl<_$_Company>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CompanyToJson(
      this,
    );
  }
}

abstract class _Company implements Company {
  factory _Company(
      {required final int id,
      required final int ec,
      required final String hq,
      required final String eh,
      required final String sym,
      required final DateTime f,
      required final String ceo,
      required final String name,
      required final String industry,
      required final String desc}) = _$_Company;

  factory _Company.fromJson(Map<String, dynamic> json) = _$_Company.fromJson;

  @override
  int get id;
  @override
  int get ec;
  @override
  String get hq;
  @override
  String get eh;
  @override
  String get sym;
  @override
  DateTime get f;
  @override
  String get ceo;
  @override
  String get name;
  @override
  String get industry;
  @override
  String get desc;
  @override
  @JsonKey(ignore: true)
  _$$_CompanyCopyWith<_$_Company> get copyWith =>
      throw _privateConstructorUsedError;
}
