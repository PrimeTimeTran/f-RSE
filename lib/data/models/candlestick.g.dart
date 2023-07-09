// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candlestick.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CandleStick _$$_CandleStickFromJson(Map<String, dynamic> json) =>
    _$_CandleStick(
      l: (json['l'] as num).toDouble(),
      o: (json['o'] as num).toDouble(),
      h: (json['h'] as num).toDouble(),
      c: (json['c'] as num).toDouble(),
      time: json['time'] as String,
    );

Map<String, dynamic> _$$_CandleStickToJson(_$_CandleStick instance) =>
    <String, dynamic>{
      'l': instance.l,
      'o': instance.o,
      'h': instance.h,
      'c': instance.c,
      'time': instance.time,
    };
