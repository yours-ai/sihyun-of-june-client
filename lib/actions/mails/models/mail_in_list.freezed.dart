// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mail_in_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MailInList _$MailInListFromJson(Map<String, dynamic> json) {
  return _MailInList.fromJson(json);
}

/// @nodoc
mixin _$MailInList {
  int get id => throw _privateConstructorUsedError;
  int get assign => throw _privateConstructorUsedError;
  DateTime get available_at => throw _privateConstructorUsedError;
  List<Reply>? get replies => throw _privateConstructorUsedError;
  int get day => throw _privateConstructorUsedError;
  bool get has_permission => throw _privateConstructorUsedError;
  bool get is_read => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MailInListCopyWith<MailInList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MailInListCopyWith<$Res> {
  factory $MailInListCopyWith(
          MailInList value, $Res Function(MailInList) then) =
      _$MailInListCopyWithImpl<$Res, MailInList>;
  @useResult
  $Res call(
      {int id,
      int assign,
      DateTime available_at,
      List<Reply>? replies,
      int day,
      bool has_permission,
      bool is_read});
}

/// @nodoc
class _$MailInListCopyWithImpl<$Res, $Val extends MailInList>
    implements $MailInListCopyWith<$Res> {
  _$MailInListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? assign = null,
    Object? available_at = null,
    Object? replies = freezed,
    Object? day = null,
    Object? has_permission = null,
    Object? is_read = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      assign: null == assign
          ? _value.assign
          : assign // ignore: cast_nullable_to_non_nullable
              as int,
      available_at: null == available_at
          ? _value.available_at
          : available_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      replies: freezed == replies
          ? _value.replies
          : replies // ignore: cast_nullable_to_non_nullable
              as List<Reply>?,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
      has_permission: null == has_permission
          ? _value.has_permission
          : has_permission // ignore: cast_nullable_to_non_nullable
              as bool,
      is_read: null == is_read
          ? _value.is_read
          : is_read // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MailInListImplCopyWith<$Res>
    implements $MailInListCopyWith<$Res> {
  factory _$$MailInListImplCopyWith(
          _$MailInListImpl value, $Res Function(_$MailInListImpl) then) =
      __$$MailInListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int assign,
      DateTime available_at,
      List<Reply>? replies,
      int day,
      bool has_permission,
      bool is_read});
}

/// @nodoc
class __$$MailInListImplCopyWithImpl<$Res>
    extends _$MailInListCopyWithImpl<$Res, _$MailInListImpl>
    implements _$$MailInListImplCopyWith<$Res> {
  __$$MailInListImplCopyWithImpl(
      _$MailInListImpl _value, $Res Function(_$MailInListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? assign = null,
    Object? available_at = null,
    Object? replies = freezed,
    Object? day = null,
    Object? has_permission = null,
    Object? is_read = null,
  }) {
    return _then(_$MailInListImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      assign: null == assign
          ? _value.assign
          : assign // ignore: cast_nullable_to_non_nullable
              as int,
      available_at: null == available_at
          ? _value.available_at
          : available_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      replies: freezed == replies
          ? _value._replies
          : replies // ignore: cast_nullable_to_non_nullable
              as List<Reply>?,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
      has_permission: null == has_permission
          ? _value.has_permission
          : has_permission // ignore: cast_nullable_to_non_nullable
              as bool,
      is_read: null == is_read
          ? _value.is_read
          : is_read // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MailInListImpl implements _MailInList {
  _$MailInListImpl(
      {required this.id,
      required this.assign,
      required this.available_at,
      final List<Reply>? replies,
      required this.day,
      required this.has_permission,
      required this.is_read})
      : _replies = replies;

  factory _$MailInListImpl.fromJson(Map<String, dynamic> json) =>
      _$$MailInListImplFromJson(json);

  @override
  final int id;
  @override
  final int assign;
  @override
  final DateTime available_at;
  final List<Reply>? _replies;
  @override
  List<Reply>? get replies {
    final value = _replies;
    if (value == null) return null;
    if (_replies is EqualUnmodifiableListView) return _replies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int day;
  @override
  final bool has_permission;
  @override
  final bool is_read;

  @override
  String toString() {
    return 'MailInList(id: $id, assign: $assign, available_at: $available_at, replies: $replies, day: $day, has_permission: $has_permission, is_read: $is_read)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MailInListImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.assign, assign) || other.assign == assign) &&
            (identical(other.available_at, available_at) ||
                other.available_at == available_at) &&
            const DeepCollectionEquality().equals(other._replies, _replies) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.has_permission, has_permission) ||
                other.has_permission == has_permission) &&
            (identical(other.is_read, is_read) || other.is_read == is_read));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      assign,
      available_at,
      const DeepCollectionEquality().hash(_replies),
      day,
      has_permission,
      is_read);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MailInListImplCopyWith<_$MailInListImpl> get copyWith =>
      __$$MailInListImplCopyWithImpl<_$MailInListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MailInListImplToJson(
      this,
    );
  }
}

abstract class _MailInList implements MailInList {
  factory _MailInList(
      {required final int id,
      required final int assign,
      required final DateTime available_at,
      final List<Reply>? replies,
      required final int day,
      required final bool has_permission,
      required final bool is_read}) = _$MailInListImpl;

  factory _MailInList.fromJson(Map<String, dynamic> json) =
      _$MailInListImpl.fromJson;

  @override
  int get id;
  @override
  int get assign;
  @override
  DateTime get available_at;
  @override
  List<Reply>? get replies;
  @override
  int get day;
  @override
  bool get has_permission;
  @override
  bool get is_read;
  @override
  @JsonKey(ignore: true)
  _$$MailInListImplCopyWith<_$MailInListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
