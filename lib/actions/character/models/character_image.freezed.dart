// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CharacterImage _$CharacterImageFromJson(Map<String, dynamic> json) {
  return _CharacterImage.fromJson(json);
}

/// @nodoc
mixin _$CharacterImage {
  int get order => throw _privateConstructorUsedError;
  String get src => throw _privateConstructorUsedError;
  String get quest_text => throw _privateConstructorUsedError;
  bool get is_blurred => throw _privateConstructorUsedError;
  bool get is_main => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CharacterImageCopyWith<CharacterImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterImageCopyWith<$Res> {
  factory $CharacterImageCopyWith(
          CharacterImage value, $Res Function(CharacterImage) then) =
      _$CharacterImageCopyWithImpl<$Res, CharacterImage>;
  @useResult
  $Res call(
      {int order,
      String src,
      String quest_text,
      bool is_blurred,
      bool is_main});
}

/// @nodoc
class _$CharacterImageCopyWithImpl<$Res, $Val extends CharacterImage>
    implements $CharacterImageCopyWith<$Res> {
  _$CharacterImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? order = null,
    Object? src = null,
    Object? quest_text = null,
    Object? is_blurred = null,
    Object? is_main = null,
  }) {
    return _then(_value.copyWith(
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      src: null == src
          ? _value.src
          : src // ignore: cast_nullable_to_non_nullable
              as String,
      quest_text: null == quest_text
          ? _value.quest_text
          : quest_text // ignore: cast_nullable_to_non_nullable
              as String,
      is_blurred: null == is_blurred
          ? _value.is_blurred
          : is_blurred // ignore: cast_nullable_to_non_nullable
              as bool,
      is_main: null == is_main
          ? _value.is_main
          : is_main // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CharacterImageImplCopyWith<$Res>
    implements $CharacterImageCopyWith<$Res> {
  factory _$$CharacterImageImplCopyWith(_$CharacterImageImpl value,
          $Res Function(_$CharacterImageImpl) then) =
      __$$CharacterImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int order,
      String src,
      String quest_text,
      bool is_blurred,
      bool is_main});
}

/// @nodoc
class __$$CharacterImageImplCopyWithImpl<$Res>
    extends _$CharacterImageCopyWithImpl<$Res, _$CharacterImageImpl>
    implements _$$CharacterImageImplCopyWith<$Res> {
  __$$CharacterImageImplCopyWithImpl(
      _$CharacterImageImpl _value, $Res Function(_$CharacterImageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? order = null,
    Object? src = null,
    Object? quest_text = null,
    Object? is_blurred = null,
    Object? is_main = null,
  }) {
    return _then(_$CharacterImageImpl(
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      src: null == src
          ? _value.src
          : src // ignore: cast_nullable_to_non_nullable
              as String,
      quest_text: null == quest_text
          ? _value.quest_text
          : quest_text // ignore: cast_nullable_to_non_nullable
              as String,
      is_blurred: null == is_blurred
          ? _value.is_blurred
          : is_blurred // ignore: cast_nullable_to_non_nullable
              as bool,
      is_main: null == is_main
          ? _value.is_main
          : is_main // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CharacterImageImpl implements _CharacterImage {
  _$CharacterImageImpl(
      {required this.order,
      required this.src,
      required this.quest_text,
      required this.is_blurred,
      required this.is_main});

  factory _$CharacterImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharacterImageImplFromJson(json);

  @override
  final int order;
  @override
  final String src;
  @override
  final String quest_text;
  @override
  final bool is_blurred;
  @override
  final bool is_main;

  @override
  String toString() {
    return 'CharacterImage(order: $order, src: $src, quest_text: $quest_text, is_blurred: $is_blurred, is_main: $is_main)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharacterImageImpl &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.src, src) || other.src == src) &&
            (identical(other.quest_text, quest_text) ||
                other.quest_text == quest_text) &&
            (identical(other.is_blurred, is_blurred) ||
                other.is_blurred == is_blurred) &&
            (identical(other.is_main, is_main) || other.is_main == is_main));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, order, src, quest_text, is_blurred, is_main);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CharacterImageImplCopyWith<_$CharacterImageImpl> get copyWith =>
      __$$CharacterImageImplCopyWithImpl<_$CharacterImageImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CharacterImageImplToJson(
      this,
    );
  }
}

abstract class _CharacterImage implements CharacterImage {
  factory _CharacterImage(
      {required final int order,
      required final String src,
      required final String quest_text,
      required final bool is_blurred,
      required final bool is_main}) = _$CharacterImageImpl;

  factory _CharacterImage.fromJson(Map<String, dynamic> json) =
      _$CharacterImageImpl.fromJson;

  @override
  int get order;
  @override
  String get src;
  @override
  String get quest_text;
  @override
  bool get is_blurred;
  @override
  bool get is_main;
  @override
  @JsonKey(ignore: true)
  _$$CharacterImageImplCopyWith<_$CharacterImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
