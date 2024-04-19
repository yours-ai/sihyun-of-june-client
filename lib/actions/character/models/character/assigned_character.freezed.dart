// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assigned_character.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AssignedCharacter _$AssignedCharacterFromJson(Map<String, dynamic> json) {
  return _AssignedCharacter.fromJson(json);
}

/// @nodoc
mixin _$AssignedCharacter {
  int get assigned_character_id => throw _privateConstructorUsedError;
  DateTime get first_mail_available_at => throw _privateConstructorUsedError;
  bool get is_active => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AssignedCharacterCopyWith<AssignedCharacter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssignedCharacterCopyWith<$Res> {
  factory $AssignedCharacterCopyWith(
          AssignedCharacter value, $Res Function(AssignedCharacter) then) =
      _$AssignedCharacterCopyWithImpl<$Res, AssignedCharacter>;
  @useResult
  $Res call(
      {int assigned_character_id,
      DateTime first_mail_available_at,
      bool is_active});
}

/// @nodoc
class _$AssignedCharacterCopyWithImpl<$Res, $Val extends AssignedCharacter>
    implements $AssignedCharacterCopyWith<$Res> {
  _$AssignedCharacterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assigned_character_id = null,
    Object? first_mail_available_at = null,
    Object? is_active = null,
  }) {
    return _then(_value.copyWith(
      assigned_character_id: null == assigned_character_id
          ? _value.assigned_character_id
          : assigned_character_id // ignore: cast_nullable_to_non_nullable
              as int,
      first_mail_available_at: null == first_mail_available_at
          ? _value.first_mail_available_at
          : first_mail_available_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      is_active: null == is_active
          ? _value.is_active
          : is_active // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AssignedCharacterImplCopyWith<$Res>
    implements $AssignedCharacterCopyWith<$Res> {
  factory _$$AssignedCharacterImplCopyWith(_$AssignedCharacterImpl value,
          $Res Function(_$AssignedCharacterImpl) then) =
      __$$AssignedCharacterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int assigned_character_id,
      DateTime first_mail_available_at,
      bool is_active});
}

/// @nodoc
class __$$AssignedCharacterImplCopyWithImpl<$Res>
    extends _$AssignedCharacterCopyWithImpl<$Res, _$AssignedCharacterImpl>
    implements _$$AssignedCharacterImplCopyWith<$Res> {
  __$$AssignedCharacterImplCopyWithImpl(_$AssignedCharacterImpl _value,
      $Res Function(_$AssignedCharacterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assigned_character_id = null,
    Object? first_mail_available_at = null,
    Object? is_active = null,
  }) {
    return _then(_$AssignedCharacterImpl(
      assigned_character_id: null == assigned_character_id
          ? _value.assigned_character_id
          : assigned_character_id // ignore: cast_nullable_to_non_nullable
              as int,
      first_mail_available_at: null == first_mail_available_at
          ? _value.first_mail_available_at
          : first_mail_available_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      is_active: null == is_active
          ? _value.is_active
          : is_active // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssignedCharacterImpl implements _AssignedCharacter {
  _$AssignedCharacterImpl(
      {required this.assigned_character_id,
      required this.first_mail_available_at,
      required this.is_active});

  factory _$AssignedCharacterImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssignedCharacterImplFromJson(json);

  @override
  final int assigned_character_id;
  @override
  final DateTime first_mail_available_at;
  @override
  final bool is_active;

  @override
  String toString() {
    return 'AssignedCharacter(assigned_character_id: $assigned_character_id, first_mail_available_at: $first_mail_available_at, is_active: $is_active)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssignedCharacterImpl &&
            (identical(other.assigned_character_id, assigned_character_id) ||
                other.assigned_character_id == assigned_character_id) &&
            (identical(
                    other.first_mail_available_at, first_mail_available_at) ||
                other.first_mail_available_at == first_mail_available_at) &&
            (identical(other.is_active, is_active) ||
                other.is_active == is_active));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, assigned_character_id, first_mail_available_at, is_active);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AssignedCharacterImplCopyWith<_$AssignedCharacterImpl> get copyWith =>
      __$$AssignedCharacterImplCopyWithImpl<_$AssignedCharacterImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssignedCharacterImplToJson(
      this,
    );
  }
}

abstract class _AssignedCharacter implements AssignedCharacter {
  factory _AssignedCharacter(
      {required final int assigned_character_id,
      required final DateTime first_mail_available_at,
      required final bool is_active}) = _$AssignedCharacterImpl;

  factory _AssignedCharacter.fromJson(Map<String, dynamic> json) =
      _$AssignedCharacterImpl.fromJson;

  @override
  int get assigned_character_id;
  @override
  DateTime get first_mail_available_at;
  @override
  bool get is_active;
  @override
  @JsonKey(ignore: true)
  _$$AssignedCharacterImplCopyWith<_$AssignedCharacterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
