// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_colors.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CharacterColors _$CharacterColorsFromJson(Map<String, dynamic> json) {
  return _CharacterColors.fromJson(json);
}

/// @nodoc
mixin _$CharacterColors {
  int get primary => throw _privateConstructorUsedError;
  int get secondary => throw _privateConstructorUsedError;
  int get inverse_primary => throw _privateConstructorUsedError;
  int get inverse_on_surface => throw _privateConstructorUsedError;
  int get inverse_surface => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CharacterColorsCopyWith<CharacterColors> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterColorsCopyWith<$Res> {
  factory $CharacterColorsCopyWith(
          CharacterColors value, $Res Function(CharacterColors) then) =
      _$CharacterColorsCopyWithImpl<$Res, CharacterColors>;
  @useResult
  $Res call(
      {int primary,
      int secondary,
      int inverse_primary,
      int inverse_on_surface,
      int inverse_surface});
}

/// @nodoc
class _$CharacterColorsCopyWithImpl<$Res, $Val extends CharacterColors>
    implements $CharacterColorsCopyWith<$Res> {
  _$CharacterColorsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primary = null,
    Object? secondary = null,
    Object? inverse_primary = null,
    Object? inverse_on_surface = null,
    Object? inverse_surface = null,
  }) {
    return _then(_value.copyWith(
      primary: null == primary
          ? _value.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as int,
      secondary: null == secondary
          ? _value.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as int,
      inverse_primary: null == inverse_primary
          ? _value.inverse_primary
          : inverse_primary // ignore: cast_nullable_to_non_nullable
              as int,
      inverse_on_surface: null == inverse_on_surface
          ? _value.inverse_on_surface
          : inverse_on_surface // ignore: cast_nullable_to_non_nullable
              as int,
      inverse_surface: null == inverse_surface
          ? _value.inverse_surface
          : inverse_surface // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CharacterColorsImplCopyWith<$Res>
    implements $CharacterColorsCopyWith<$Res> {
  factory _$$CharacterColorsImplCopyWith(_$CharacterColorsImpl value,
          $Res Function(_$CharacterColorsImpl) then) =
      __$$CharacterColorsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int primary,
      int secondary,
      int inverse_primary,
      int inverse_on_surface,
      int inverse_surface});
}

/// @nodoc
class __$$CharacterColorsImplCopyWithImpl<$Res>
    extends _$CharacterColorsCopyWithImpl<$Res, _$CharacterColorsImpl>
    implements _$$CharacterColorsImplCopyWith<$Res> {
  __$$CharacterColorsImplCopyWithImpl(
      _$CharacterColorsImpl _value, $Res Function(_$CharacterColorsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primary = null,
    Object? secondary = null,
    Object? inverse_primary = null,
    Object? inverse_on_surface = null,
    Object? inverse_surface = null,
  }) {
    return _then(_$CharacterColorsImpl(
      primary: null == primary
          ? _value.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as int,
      secondary: null == secondary
          ? _value.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as int,
      inverse_primary: null == inverse_primary
          ? _value.inverse_primary
          : inverse_primary // ignore: cast_nullable_to_non_nullable
              as int,
      inverse_on_surface: null == inverse_on_surface
          ? _value.inverse_on_surface
          : inverse_on_surface // ignore: cast_nullable_to_non_nullable
              as int,
      inverse_surface: null == inverse_surface
          ? _value.inverse_surface
          : inverse_surface // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CharacterColorsImpl implements _CharacterColors {
  _$CharacterColorsImpl(
      {required this.primary,
      required this.secondary,
      required this.inverse_primary,
      required this.inverse_on_surface,
      required this.inverse_surface});

  factory _$CharacterColorsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharacterColorsImplFromJson(json);

  @override
  final int primary;
  @override
  final int secondary;
  @override
  final int inverse_primary;
  @override
  final int inverse_on_surface;
  @override
  final int inverse_surface;

  @override
  String toString() {
    return 'CharacterColors(primary: $primary, secondary: $secondary, inverse_primary: $inverse_primary, inverse_on_surface: $inverse_on_surface, inverse_surface: $inverse_surface)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharacterColorsImpl &&
            (identical(other.primary, primary) || other.primary == primary) &&
            (identical(other.secondary, secondary) ||
                other.secondary == secondary) &&
            (identical(other.inverse_primary, inverse_primary) ||
                other.inverse_primary == inverse_primary) &&
            (identical(other.inverse_on_surface, inverse_on_surface) ||
                other.inverse_on_surface == inverse_on_surface) &&
            (identical(other.inverse_surface, inverse_surface) ||
                other.inverse_surface == inverse_surface));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, primary, secondary,
      inverse_primary, inverse_on_surface, inverse_surface);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CharacterColorsImplCopyWith<_$CharacterColorsImpl> get copyWith =>
      __$$CharacterColorsImplCopyWithImpl<_$CharacterColorsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CharacterColorsImplToJson(
      this,
    );
  }
}

abstract class _CharacterColors implements CharacterColors {
  factory _CharacterColors(
      {required final int primary,
      required final int secondary,
      required final int inverse_primary,
      required final int inverse_on_surface,
      required final int inverse_surface}) = _$CharacterColorsImpl;

  factory _CharacterColors.fromJson(Map<String, dynamic> json) =
      _$CharacterColorsImpl.fromJson;

  @override
  int get primary;
  @override
  int get secondary;
  @override
  int get inverse_primary;
  @override
  int get inverse_on_surface;
  @override
  int get inverse_surface;
  @override
  @JsonKey(ignore: true)
  _$$CharacterColorsImplCopyWith<_$CharacterColorsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
