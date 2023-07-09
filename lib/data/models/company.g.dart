// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Company _$$_CompanyFromJson(Map<String, dynamic> json) => _$_Company(
      id: json['id'] as int,
      ec: json['ec'] as int,
      hq: json['hq'] as String,
      eh: json['eh'] as String,
      sym: json['sym'] as String,
      f: DateTime.parse(json['f'] as String),
      ceo: json['ceo'] as String,
      name: json['name'] as String,
      industry: json['industry'] as String,
      desc: json['desc'] as String,
    );

Map<String, dynamic> _$$_CompanyToJson(_$_Company instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ec': instance.ec,
      'hq': instance.hq,
      'eh': instance.eh,
      'sym': instance.sym,
      'f': instance.f.toIso8601String(),
      'ceo': instance.ceo,
      'name': instance.name,
      'industry': instance.industry,
      'desc': instance.desc,
    };
