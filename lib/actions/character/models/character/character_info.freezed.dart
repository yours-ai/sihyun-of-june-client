// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CharacterInfo _$CharacterInfoFromJson(Map<String, dynamic> json) {
  return _CharacterInfo.fromJson(json);
}

/// @nodoc
mixin _$CharacterInfo {
  num get age => throw _privateConstructorUsedError;
  String get one_line_description => throw _privateConstructorUsedError;
  String get summary_description => throw _privateConstructorUsedError;
  CharacterCinematic get cinematic => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<CharacterImage> get images => throw _privateConstructorUsedError;
  List<CharacterSns>? get sns => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CharacterInfoCopyWith<CharacterInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterInfoCopyWith<$Res> {
  factory $CharacterInfoCopyWith(
          CharacterInfo value, $Res Function(CharacterInfo) then) =
      _$CharacterInfoCopyWithImpl<$Res, CharacterInfo>;
  @useResult
  $Res call(
      {num age,
      String one_line_description,
      String summary_description,
      CharacterCinematic cinematic,
      String description,
      List<CharacterImage> images,
      List<CharacterSns>? sns});

  $CharacterCinematicCopyWith<$Res> get cinematic;
}

/// @nodoc
class _$CharacterInfoCopyWithImpl<$Res, $Val extends CharacterInfo>
    implements $CharacterInfoCopyWith<$Res> {
  _$CharacterInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? age = null,
    Object? one_line_description = null,
    Object? summary_description = null,
    Object? cinematic = null,
    Object? description = null,
    Object? images = null,
    Object? sns = freezed,
  }) {
    return _then(_value.copyWith(
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as num,
      one_line_description: null == one_line_description
          ? _value.one_line_description
          : one_line_description // ignore: cast_nullable_to_non_nullable
              as String,
      summary_description: null == summary_description
          ? _value.summary_description
          : summary_description // ignore: cast_nullable_to_non_nullable
              as String,
      cinematic: null == cinematic
          ? _value.cinematic
          : cinematic // ignore: cast_nullable_to_non_nullable
              as CharacterCinematic,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<CharacterImage>,
      sns: freezed == sns
          ? _value.sns
          : sns // ignore: cast_nullable_to_non_nullable
              as List<CharacterSns>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CharacterCinematicCopyWith<$Res> get cinematic {
    return $CharacterCinematicCopyWith<$Res>(_value.cinematic, (value) {
      return _then(_value.copyWith(cinematic: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CharacterInfoImplCopyWith<$Res>
    implements $CharacterInfoCopyWith<$Res> {
  factory _$$CharacterInfoImplCopyWith(
          _$CharacterInfoImpl value, $Res Function(_$CharacterInfoImpl) then) =
      __$$CharacterInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {num age,
      String one_line_description,
      String summary_description,
      CharacterCinematic cinematic,
      String description,
      List<CharacterImage> images,
      List<CharacterSns>? sns});

  @override
  $CharacterCinematicCopyWith<$Res> get cinematic;
}

/// @nodoc
class __$$CharacterInfoImplCopyWithImpl<$Res>
    extends _$CharacterInfoCopyWithImpl<$Res, _$CharacterInfoImpl>
    implements _$$CharacterInfoImplCopyWith<$Res> {
  __$$CharacterInfoImplCopyWithImpl(
      _$CharacterInfoImpl _value, $Res Function(_$CharacterInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? age = null,
    Object? one_line_description = null,
    Object? summary_description = null,
    Object? cinematic = null,
    Object? description = null,
    Object? images = null,
    Object? sns = freezed,
  }) {
    return _then(_$CharacterInfoImpl(
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as num,
      one_line_description: null == one_line_description
          ? _value.one_line_description
          : one_line_description // ignore: cast_nullable_to_non_nullable
              as String,
      summary_description: null == summary_description
          ? _value.summary_description
          : summary_description // ignore: cast_nullable_to_non_nullable
              as String,
      cinematic: null == cinematic
          ? _value.cinematic
          : cinematic // ignore: cast_nullable_to_non_nullable
              as CharacterCinematic,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<CharacterImage>,
      sns: freezed == sns
          ? _value._sns
          : sns // ignore: cast_nullable_to_non_nullable
              as List<CharacterSns>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CharacterInfoImpl implements _CharacterInfo {
  _$CharacterInfoImpl(
      {required this.age,
      required this.one_line_description,
      required this.summary_description,
      required this.cinematic,
      required this.description,
      required final List<CharacterImage> images,
      final List<CharacterSns>? sns})
      : _images = images,
        _sns = sns;

  factory _$CharacterInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharacterInfoImplFromJson(json);

  @override
  final num age;
  @override
  final String one_line_description;
  @override
  final String summary_description;
  @override
  final CharacterCinematic cinematic;
  @override
  final String description;
  final List<CharacterImage> _images;
  @override
  List<CharacterImage> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  final List<CharacterSns>? _sns;
  @override
  List<CharacterSns>? get sns {
    final value = _sns;
    if (value == null) return null;
    if (_sns is EqualUnmodifiableListView) return _sns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CharacterInfo(age: $age, one_line_description: $one_line_description, summary_description: $summary_description, cinematic: $cinematic, description: $description, images: $images, sns: $sns)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharacterInfoImpl &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.one_line_description, one_line_description) ||
                other.one_line_description == one_line_description) &&
            (identical(other.summary_description, summary_description) ||
                other.summary_description == summary_description) &&
            (identical(other.cinematic, cinematic) ||
                other.cinematic == cinematic) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality().equals(other._sns, _sns));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      age,
      one_line_description,
      summary_description,
      cinematic,
      description,
      const DeepCollectionEquality().hash(_images),
      const DeepCollectionEquality().hash(_sns));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CharacterInfoImplCopyWith<_$CharacterInfoImpl> get copyWith =>
      __$$CharacterInfoImplCopyWithImpl<_$CharacterInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CharacterInfoImplToJson(
      this,
    );
  }
}

abstract class _CharacterInfo implements CharacterInfo {
  factory _CharacterInfo(
      {required final num age,
      required final String one_line_description,
      required final String summary_description,
      required final CharacterCinematic cinematic,
      required final String description,
      required final List<CharacterImage> images,
      final List<CharacterSns>? sns}) = _$CharacterInfoImpl;

  factory _CharacterInfo.fromJson(Map<String, dynamic> json) =
      _$CharacterInfoImpl.fromJson;

  @override
  num get age;
  @override
  String get one_line_description;
  @override
  String get summary_description;
  @override
  CharacterCinematic get cinematic;
  @override
  String get description;
  @override
  List<CharacterImage> get images;
  @override
  List<CharacterSns>? get sns;
  @override
  @JsonKey(ignore: true)
  _$$CharacterInfoImplCopyWith<_$CharacterInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
