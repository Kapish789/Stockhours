// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fs_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Market _$MarketFromJson(Map<String, dynamic> json) => Market(
      name: json['name'] as String? ?? "",
      open: json['open'] as String? ?? "",
      close: json['close'] as String? ?? "",
      flag: json['flag'] as String? ?? "",
    );

Map<String, dynamic> _$MarketToJson(Market instance) => <String, dynamic>{
      'name': instance.name,
      'open': instance.open,
      'close': instance.close,
      'flag': instance.flag,
    };

MarketList _$MarketListFromJson(Map<String, dynamic> json) => MarketList(
      markets: (json['markets'] as List<dynamic>?)
              ?.map((e) => Market.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MarketListToJson(MarketList instance) =>
    <String, dynamic>{
      'markets': instance.markets,
    };
