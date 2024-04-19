import 'package:freezed_annotation/freezed_annotation.dart';

part 'date_and_weather.freezed.dart';

part 'date_and_weather.g.dart';

@freezed
class DateAndWeather with _$DateAndWeather {
  factory DateAndWeather({
    required String text,
    required String weather,
  }) = _DateAndWeather;

  factory DateAndWeather.fromJson(Map<String, dynamic> json) =>
      _$DateAndWeatherFromJson(json);
}
