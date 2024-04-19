// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CharacterTheme _$CharacterThemeFromJson(Map<String, dynamic> json) {
  return _CharacterTheme.fromJson(json);
}

/// @nodoc
mixin _$CharacterTheme {
  CharacterColors get colors => throw _privateConstructorUsedError;
  String get font => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CharacterThemeCopyWith<CharacterTheme> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterThemeCopyWith<$Res> {
  factory $CharacterThemeCopyWith(
          CharacterTheme value, $Res Function(CharacterTheme) then) =
      _$CharacterThemeCopyWithImpl<$Res, CharacterTheme>;
  @useResult
  $Res call({CharacterColors colors, String font});

  $CharacterColorsCopyWith<$Res> get colors;
}

/// @nodoc
class _$CharacterThemeCopyWithImpl<$Res, $Val extends CharacterTheme>
    implements $CharacterThemeCopyWith<$Res> {
  _$CharacterThemeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? colors = null,
    Object? font = null,
  }) {
    return _then(_value.copyWith(
      colors: null == colors
          ? _value.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as CharacterColors,
      font: null == font
          ? _value.font
          : font // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CharacterColorsCopyWith<$Res> get colors {
    return $CharacterColorsCopyWith<$Res>(_value.colors, (value) {
      return _then(_value.copyWith(colors: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CharacterThemeImplCopyWith<$Res>
    implements $CharacterThemeCopyWith<$Res> {
  factory _$$CharacterThemeImplCopyWith(_$CharacterThemeImpl value,
          $Res Function(_$CharacterThemeImpl) then) =
      __$$CharacterThemeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({CharacterColors colors, String font});

  @override
  $CharacterColorsCopyWith<$Res> get colors;
}

/// @nodoc
class __$$CharacterThemeImplCopyWithImpl<$Res>
    extends _$CharacterThemeCopyWithImpl<$Res, _$CharacterThemeImpl>
    implements _$$CharacterThemeImplCopyWith<$Res> {
  __$$CharacterThemeImplCopyWithImpl(
      _$CharacterThemeImpl _value, $Res Function(_$CharacterThemeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? colors = null,
    Object? font = null,
  }) {
    return _then(_$CharacterThemeImpl(
      colors: null == colors
          ? _value.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as CharacterColors,
      font: null == font
          ? _value.font
          : font // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CharacterThemeImpl implements _CharacterTheme {
  _$CharacterThemeImpl({required this.colors, required this.font});

  factory _$CharacterThemeImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharacterThemeImplFromJson(json);

  @override
  final CharacterColors colors;
  @override
  final String font;

  @override
  String toString() {
    return 'CharacterTheme(colors: $colors, font: $font)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharacterThemeImpl &&
            (identical(other.colors, colors) || other.colors == colors) &&
            (identical(other.font, font) || other.font == font));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, colors, font);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CharacterThemeImplCopyWith<_$CharacterThemeImpl> get copyWith =>
      __$$CharacterThemeImplCopyWithImpl<_$CharacterThemeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CharacterThemeImplToJson(
      this,
    );
  }
}

abstract class _CharacterTheme implements CharacterTheme {
  factory _CharacterTheme(
      {required final CharacterColors colors,
      required final String font}) = _$CharacterThemeImpl;

  factory _CharacterTheme.fromJson(Map<String, dynamic> json) =
      _$CharacterThemeImpl.fromJson;

  @override
  CharacterColors get colors;
  @override
  String get font;
  @override
  @JsonKey(ignore: true)
  _$$CharacterThemeImplCopyWith<_$CharacterThemeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
