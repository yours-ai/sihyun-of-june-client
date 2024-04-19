// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'date_and_weather.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DateAndWeather _$DateAndWeatherFromJson(Map<String, dynamic> json) {
  return _DateAndWeather.fromJson(json);
}

/// @nodoc
mixin _$DateAndWeather {
  String get text => throw _privateConstructorUsedError;
  String get weather => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DateAndWeatherCopyWith<DateAndWeather> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DateAndWeatherCopyWith<$Res> {
  factory $DateAndWeatherCopyWith(
          DateAndWeather value, $Res Function(DateAndWeather) then) =
      _$DateAndWeatherCopyWithImpl<$Res, DateAndWeather>;
  @useResult
  $Res call({String text, String weather});
}

/// @nodoc
class _$DateAndWeatherCopyWithImpl<$Res, $Val extends DateAndWeather>
    implements $DateAndWeatherCopyWith<$Res> {
  _$DateAndWeatherCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? weather = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      weather: null == weather
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DateAndWeatherImplCopyWith<$Res>
    implements $DateAndWeatherCopyWith<$Res> {
  factory _$$DateAndWeatherImplCopyWith(_$DateAndWeatherImpl value,
          $Res Function(_$DateAndWeatherImpl) then) =
      __$$DateAndWeatherImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, String weather});
}

/// @nodoc
class __$$DateAndWeatherImplCopyWithImpl<$Res>
    extends _$DateAndWeatherCopyWithImpl<$Res, _$DateAndWeatherImpl>
    implements _$$DateAndWeatherImplCopyWith<$Res> {
  __$$DateAndWeatherImplCopyWithImpl(
      _$DateAndWeatherImpl _value, $Res Function(_$DateAndWeatherImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? weather = null,
  }) {
    return _then(_$DateAndWeatherImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      weather: null == weather
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DateAndWeatherImpl implements _DateAndWeather {
  _$DateAndWeatherImpl({required this.text, required this.weather});

  factory _$DateAndWeatherImpl.fromJson(Map<String, dynamic> json) =>
      _$$DateAndWeatherImplFromJson(json);

  @override
  final String text;
  @override
  final String weather;

  @override
  String toString() {
    return 'DateAndWeather(text: $text, weather: $weather)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DateAndWeatherImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.weather, weather) || other.weather == weather));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, text, weather);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DateAndWeatherImplCopyWith<_$DateAndWeatherImpl> get copyWith =>
      __$$DateAndWeatherImplCopyWithImpl<_$DateAndWeatherImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DateAndWeatherImplToJson(
      this,
    );
  }
}

abstract class _DateAndWeather implements DateAndWeather {
  factory _DateAndWeather(
      {required final String text,
      required final String weather}) = _$DateAndWeatherImpl;

  factory _DateAndWeather.fromJson(Map<String, dynamic> json) =
      _$DateAndWeatherImpl.fromJson;

  @override
  String get text;
  @override
  String get weather;
  @override
  @JsonKey(ignore: true)
  _$$DateAndWeatherImplCopyWith<_$DateAndWeatherImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
