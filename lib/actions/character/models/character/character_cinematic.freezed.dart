// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_cinematic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CharacterCinematic _$CharacterCinematicFromJson(Map<String, dynamic> json) {
  return _CharacterCinematic.fromJson(json);
}

/// @nodoc
mixin _$CharacterCinematic {
  String get cinematic_background_image_1 => throw _privateConstructorUsedError;
  String get cinematic_background_image_2 => throw _privateConstructorUsedError;
  List<String> get cinematic_description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CharacterCinematicCopyWith<CharacterCinematic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterCinematicCopyWith<$Res> {
  factory $CharacterCinematicCopyWith(
          CharacterCinematic value, $Res Function(CharacterCinematic) then) =
      _$CharacterCinematicCopyWithImpl<$Res, CharacterCinematic>;
  @useResult
  $Res call(
      {String cinematic_background_image_1,
      String cinematic_background_image_2,
      List<String> cinematic_description});
}

/// @nodoc
class _$CharacterCinematicCopyWithImpl<$Res, $Val extends CharacterCinematic>
    implements $CharacterCinematicCopyWith<$Res> {
  _$CharacterCinematicCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cinematic_background_image_1 = null,
    Object? cinematic_background_image_2 = null,
    Object? cinematic_description = null,
  }) {
    return _then(_value.copyWith(
      cinematic_background_image_1: null == cinematic_background_image_1
          ? _value.cinematic_background_image_1
          : cinematic_background_image_1 // ignore: cast_nullable_to_non_nullable
              as String,
      cinematic_background_image_2: null == cinematic_background_image_2
          ? _value.cinematic_background_image_2
          : cinematic_background_image_2 // ignore: cast_nullable_to_non_nullable
              as String,
      cinematic_description: null == cinematic_description
          ? _value.cinematic_description
          : cinematic_description // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CharacterCinematicImplCopyWith<$Res>
    implements $CharacterCinematicCopyWith<$Res> {
  factory _$$CharacterCinematicImplCopyWith(_$CharacterCinematicImpl value,
          $Res Function(_$CharacterCinematicImpl) then) =
      __$$CharacterCinematicImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String cinematic_background_image_1,
      String cinematic_background_image_2,
      List<String> cinematic_description});
}

/// @nodoc
class __$$CharacterCinematicImplCopyWithImpl<$Res>
    extends _$CharacterCinematicCopyWithImpl<$Res, _$CharacterCinematicImpl>
    implements _$$CharacterCinematicImplCopyWith<$Res> {
  __$$CharacterCinematicImplCopyWithImpl(_$CharacterCinematicImpl _value,
      $Res Function(_$CharacterCinematicImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cinematic_background_image_1 = null,
    Object? cinematic_background_image_2 = null,
    Object? cinematic_description = null,
  }) {
    return _then(_$CharacterCinematicImpl(
      cinematic_background_image_1: null == cinematic_background_image_1
          ? _value.cinematic_background_image_1
          : cinematic_background_image_1 // ignore: cast_nullable_to_non_nullable
              as String,
      cinematic_background_image_2: null == cinematic_background_image_2
          ? _value.cinematic_background_image_2
          : cinematic_background_image_2 // ignore: cast_nullable_to_non_nullable
              as String,
      cinematic_description: null == cinematic_description
          ? _value._cinematic_description
          : cinematic_description // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CharacterCinematicImpl implements _CharacterCinematic {
  _$CharacterCinematicImpl(
      {required this.cinematic_background_image_1,
      required this.cinematic_background_image_2,
      required final List<String> cinematic_description})
      : _cinematic_description = cinematic_description;

  factory _$CharacterCinematicImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharacterCinematicImplFromJson(json);

  @override
  final String cinematic_background_image_1;
  @override
  final String cinematic_background_image_2;
  final List<String> _cinematic_description;
  @override
  List<String> get cinematic_description {
    if (_cinematic_description is EqualUnmodifiableListView)
      return _cinematic_description;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cinematic_description);
  }

  @override
  String toString() {
    return 'CharacterCinematic(cinematic_background_image_1: $cinematic_background_image_1, cinematic_background_image_2: $cinematic_background_image_2, cinematic_description: $cinematic_description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharacterCinematicImpl &&
            (identical(other.cinematic_background_image_1,
                    cinematic_background_image_1) ||
                other.cinematic_background_image_1 ==
                    cinematic_background_image_1) &&
            (identical(other.cinematic_background_image_2,
                    cinematic_background_image_2) ||
                other.cinematic_background_image_2 ==
                    cinematic_background_image_2) &&
            const DeepCollectionEquality()
                .equals(other._cinematic_description, _cinematic_description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      cinematic_background_image_1,
      cinematic_background_image_2,
      const DeepCollectionEquality().hash(_cinematic_description));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CharacterCinematicImplCopyWith<_$CharacterCinematicImpl> get copyWith =>
      __$$CharacterCinematicImplCopyWithImpl<_$CharacterCinematicImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CharacterCinematicImplToJson(
      this,
    );
  }
}

abstract class _CharacterCinematic implements CharacterCinematic {
  factory _CharacterCinematic(
          {required final String cinematic_background_image_1,
          required final String cinematic_background_image_2,
          required final List<String> cinematic_description}) =
      _$CharacterCinematicImpl;

  factory _CharacterCinematic.fromJson(Map<String, dynamic> json) =
      _$CharacterCinematicImpl.fromJson;

  @override
  String get cinematic_background_image_1;
  @override
  String get cinematic_background_image_2;
  @override
  List<String> get cinematic_description;
  @override
  @JsonKey(ignore: true)
  _$$CharacterCinematicImplCopyWith<_$CharacterCinematicImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
