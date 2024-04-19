// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Character _$CharacterFromJson(Map<String, dynamic> json) {
  return _Character.fromJson(json);
}

/// @nodoc
mixin _$Character {
  int get id => throw _privateConstructorUsedError;
  bool get is_active => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get first_name => throw _privateConstructorUsedError;
  CharacterInfo get character_info => throw _privateConstructorUsedError;
  CharacterTheme get theme => throw _privateConstructorUsedError;
  bool? get is_image_updated => throw _privateConstructorUsedError;
  List<AssignedCharacter>? get assigned_characters =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CharacterCopyWith<Character> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterCopyWith<$Res> {
  factory $CharacterCopyWith(Character value, $Res Function(Character) then) =
      _$CharacterCopyWithImpl<$Res, Character>;
  @useResult
  $Res call(
      {int id,
      bool is_active,
      String name,
      String first_name,
      CharacterInfo character_info,
      CharacterTheme theme,
      bool? is_image_updated,
      List<AssignedCharacter>? assigned_characters});

  $CharacterInfoCopyWith<$Res> get character_info;
  $CharacterThemeCopyWith<$Res> get theme;
}

/// @nodoc
class _$CharacterCopyWithImpl<$Res, $Val extends Character>
    implements $CharacterCopyWith<$Res> {
  _$CharacterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? is_active = null,
    Object? name = null,
    Object? first_name = null,
    Object? character_info = null,
    Object? theme = null,
    Object? is_image_updated = freezed,
    Object? assigned_characters = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      is_active: null == is_active
          ? _value.is_active
          : is_active // ignore: cast_nullable_to_non_nullable
              as bool,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      first_name: null == first_name
          ? _value.first_name
          : first_name // ignore: cast_nullable_to_non_nullable
              as String,
      character_info: null == character_info
          ? _value.character_info
          : character_info // ignore: cast_nullable_to_non_nullable
              as CharacterInfo,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as CharacterTheme,
      is_image_updated: freezed == is_image_updated
          ? _value.is_image_updated
          : is_image_updated // ignore: cast_nullable_to_non_nullable
              as bool?,
      assigned_characters: freezed == assigned_characters
          ? _value.assigned_characters
          : assigned_characters // ignore: cast_nullable_to_non_nullable
              as List<AssignedCharacter>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CharacterInfoCopyWith<$Res> get character_info {
    return $CharacterInfoCopyWith<$Res>(_value.character_info, (value) {
      return _then(_value.copyWith(character_info: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CharacterThemeCopyWith<$Res> get theme {
    return $CharacterThemeCopyWith<$Res>(_value.theme, (value) {
      return _then(_value.copyWith(theme: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CharacterImplCopyWith<$Res>
    implements $CharacterCopyWith<$Res> {
  factory _$$CharacterImplCopyWith(
          _$CharacterImpl value, $Res Function(_$CharacterImpl) then) =
      __$$CharacterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      bool is_active,
      String name,
      String first_name,
      CharacterInfo character_info,
      CharacterTheme theme,
      bool? is_image_updated,
      List<AssignedCharacter>? assigned_characters});

  @override
  $CharacterInfoCopyWith<$Res> get character_info;
  @override
  $CharacterThemeCopyWith<$Res> get theme;
}

/// @nodoc
class __$$CharacterImplCopyWithImpl<$Res>
    extends _$CharacterCopyWithImpl<$Res, _$CharacterImpl>
    implements _$$CharacterImplCopyWith<$Res> {
  __$$CharacterImplCopyWithImpl(
      _$CharacterImpl _value, $Res Function(_$CharacterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? is_active = null,
    Object? name = null,
    Object? first_name = null,
    Object? character_info = null,
    Object? theme = null,
    Object? is_image_updated = freezed,
    Object? assigned_characters = freezed,
  }) {
    return _then(_$CharacterImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      is_active: null == is_active
          ? _value.is_active
          : is_active // ignore: cast_nullable_to_non_nullable
              as bool,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      first_name: null == first_name
          ? _value.first_name
          : first_name // ignore: cast_nullable_to_non_nullable
              as String,
      character_info: null == character_info
          ? _value.character_info
          : character_info // ignore: cast_nullable_to_non_nullable
              as CharacterInfo,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as CharacterTheme,
      is_image_updated: freezed == is_image_updated
          ? _value.is_image_updated
          : is_image_updated // ignore: cast_nullable_to_non_nullable
              as bool?,
      assigned_characters: freezed == assigned_characters
          ? _value._assigned_characters
          : assigned_characters // ignore: cast_nullable_to_non_nullable
              as List<AssignedCharacter>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CharacterImpl implements _Character {
  _$CharacterImpl(
      {required this.id,
      required this.is_active,
      required this.name,
      required this.first_name,
      required this.character_info,
      required this.theme,
      this.is_image_updated,
      final List<AssignedCharacter>? assigned_characters})
      : _assigned_characters = assigned_characters;

  factory _$CharacterImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharacterImplFromJson(json);

  @override
  final int id;
  @override
  final bool is_active;
  @override
  final String name;
  @override
  final String first_name;
  @override
  final CharacterInfo character_info;
  @override
  final CharacterTheme theme;
  @override
  final bool? is_image_updated;
  final List<AssignedCharacter>? _assigned_characters;
  @override
  List<AssignedCharacter>? get assigned_characters {
    final value = _assigned_characters;
    if (value == null) return null;
    if (_assigned_characters is EqualUnmodifiableListView)
      return _assigned_characters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Character(id: $id, is_active: $is_active, name: $name, first_name: $first_name, character_info: $character_info, theme: $theme, is_image_updated: $is_image_updated, assigned_characters: $assigned_characters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharacterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.is_active, is_active) ||
                other.is_active == is_active) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.first_name, first_name) ||
                other.first_name == first_name) &&
            (identical(other.character_info, character_info) ||
                other.character_info == character_info) &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.is_image_updated, is_image_updated) ||
                other.is_image_updated == is_image_updated) &&
            const DeepCollectionEquality()
                .equals(other._assigned_characters, _assigned_characters));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      is_active,
      name,
      first_name,
      character_info,
      theme,
      is_image_updated,
      const DeepCollectionEquality().hash(_assigned_characters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CharacterImplCopyWith<_$CharacterImpl> get copyWith =>
      __$$CharacterImplCopyWithImpl<_$CharacterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CharacterImplToJson(
      this,
    );
  }
}

abstract class _Character implements Character {
  factory _Character(
      {required final int id,
      required final bool is_active,
      required final String name,
      required final String first_name,
      required final CharacterInfo character_info,
      required final CharacterTheme theme,
      final bool? is_image_updated,
      final List<AssignedCharacter>? assigned_characters}) = _$CharacterImpl;

  factory _Character.fromJson(Map<String, dynamic> json) =
      _$CharacterImpl.fromJson;

  @override
  int get id;
  @override
  bool get is_active;
  @override
  String get name;
  @override
  String get first_name;
  @override
  CharacterInfo get character_info;
  @override
  CharacterTheme get theme;
  @override
  bool? get is_image_updated;
  @override
  List<AssignedCharacter>? get assigned_characters;
  @override
  @JsonKey(ignore: true)
  _$$CharacterImplCopyWith<_$CharacterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
