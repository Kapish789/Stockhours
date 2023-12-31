import "package:json_annotation/json_annotation.dart";

part "fs_models.g.dart";

@JsonSerializable()
class Market {
  final String name;
  final String open;
  final String close;
  final String flag;

  Market({
    this.name = "",
    this.open = "",
    this.close = "",
    this.flag = "",
  });

  factory Market.fromJson(Map<String, dynamic> json) => _$MarketFromJson(json);

  Map<String, dynamic> toJson() => _$MarketToJson(this);
}

@JsonSerializable()
class MarketList {
  final List<Market> markets;

  MarketList({
    this.markets = const [],
  });

  factory MarketList.fromJson(Map<String, dynamic> json) => _$MarketListFromJson(json);

  Map<String, dynamic> toJson() => _$MarketListToJson(this);
}