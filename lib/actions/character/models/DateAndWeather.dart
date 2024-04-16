import 'package:json_annotation/json_annotation.dart';

part 'DateAndWeather.g.dart';

@JsonSerializable()
class DateAndWeather {
  final String text;
  final String weather;

  DateAndWeather({
    required this.text,
    required this.weather,
  });

  factory DateAndWeather.fromJson(Map<String, dynamic> json) =>
      _$DateAndWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$DateAndWeatherToJson(this);
}

enum WeatherEnum {
  windy,
  snowy,
  sunny,
  rainy,
  littleCloudy,
  thunderstorm,
  cloudy,
}
