// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_sns.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CharacterSns _$CharacterSnsFromJson(Map<String, dynamic> json) {
  return _CharacterSns.fromJson(json);
}

/// @nodoc
mixin _$CharacterSns {
  String get platform => throw _privateConstructorUsedError;
  String get link => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CharacterSnsCopyWith<CharacterSns> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterSnsCopyWith<$Res> {
  factory $CharacterSnsCopyWith(
          CharacterSns value, $Res Function(CharacterSns) then) =
      _$CharacterSnsCopyWithImpl<$Res, CharacterSns>;
  @useResult
  $Res call({String platform, String link});
}

/// @nodoc
class _$CharacterSnsCopyWithImpl<$Res, $Val extends CharacterSns>
    implements $CharacterSnsCopyWith<$Res> {
  _$CharacterSnsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? platform = null,
    Object? link = null,
  }) {
    return _then(_value.copyWith(
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CharacterSnsImplCopyWith<$Res>
    implements $CharacterSnsCopyWith<$Res> {
  factory _$$CharacterSnsImplCopyWith(
          _$CharacterSnsImpl value, $Res Function(_$CharacterSnsImpl) then) =
      __$$CharacterSnsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String platform, String link});
}

/// @nodoc
class __$$CharacterSnsImplCopyWithImpl<$Res>
    extends _$CharacterSnsCopyWithImpl<$Res, _$CharacterSnsImpl>
    implements _$$CharacterSnsImplCopyWith<$Res> {
  __$$CharacterSnsImplCopyWithImpl(
      _$CharacterSnsImpl _value, $Res Function(_$CharacterSnsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? platform = null,
    Object? link = null,
  }) {
    return _then(_$CharacterSnsImpl(
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CharacterSnsImpl implements _CharacterSns {
  _$CharacterSnsImpl({required this.platform, required this.link});

  factory _$CharacterSnsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharacterSnsImplFromJson(json);

  @override
  final String platform;
  @override
  final String link;

  @override
  String toString() {
    return 'CharacterSns(platform: $platform, link: $link)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharacterSnsImpl &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.link, link) || other.link == link));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, platform, link);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CharacterSnsImplCopyWith<_$CharacterSnsImpl> get copyWith =>
      __$$CharacterSnsImplCopyWithImpl<_$CharacterSnsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CharacterSnsImplToJson(
      this,
    );
  }
}

abstract class _CharacterSns implements CharacterSns {
  factory _CharacterSns(
      {required final String platform,
      required final String link}) = _$CharacterSnsImpl;

  factory _CharacterSns.fromJson(Map<String, dynamic> json) =
      _$CharacterSnsImpl.fromJson;

  @override
  String get platform;
  @override
  String get link;
  @override
  @JsonKey(ignore: true)
  _$$CharacterSnsImplCopyWith<_$CharacterSnsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
