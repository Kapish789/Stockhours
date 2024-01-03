import "package:country_flags/country_flags.dart";
import "package:flutter/material.dart";
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

  String getOpenByTZ(double utcDifference) {
    int hour = int.parse(open.split(":").first);
    int minute = int.parse(open.split(":").last);

    int adjustedHour = (hour + utcDifference).floor() +
        ((minute + (utcDifference % 1) * 60) == 60 ? 1 : 0);
    int adjustedMinute = ((minute + (utcDifference % 1) * 60) % 60).round();

    // Format the adjusted time
    String adjustedTime = '${adjustedHour < 10 ? '0' : ''}$adjustedHour:'
        '${adjustedMinute < 10 ? '0' : ''}$adjustedMinute';

    return adjustedTime;
  }

  String getCloseByTZ(double utcDifference) {
    int hour = int.parse(close.split(":").first);
    int minute = int.parse(close.split(":").last);

    int adjustedHour = (hour + utcDifference).floor();
    int adjustedMinute = ((minute + (utcDifference % 1) * 60) % 60).round();

    // Format the adjusted time
    String adjustedTime = '${adjustedHour < 10 ? '0' : ''}$adjustedHour:'
        '${adjustedMinute < 10 ? '0' : ''}$adjustedMinute';

    return adjustedTime;
  }

  Widget getLabel(Color textColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CountryFlag.fromCountryCode(
          flag,
          height: 15,
          width: 15,
          borderRadius: 5,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 15,
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  factory Market.fromJson(Map<String, dynamic> json) => _$MarketFromJson(json);

  Map<String, dynamic> toJson() => _$MarketToJson(this);
}

@JsonSerializable()
class MarketList {
  final List<Market> markets;

  MarketList({
    this.markets = const [],
  });

  factory MarketList.fromJson(Map<String, dynamic> json) =>
      _$MarketListFromJson(json);

  Map<String, dynamic> toJson() => _$MarketListToJson(this);
}
