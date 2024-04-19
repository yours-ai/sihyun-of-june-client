// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mail_in_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MailInDetail _$MailInDetailFromJson(Map<String, dynamic> json) {
  return _MailInDetail.fromJson(json);
}

/// @nodoc
mixin _$MailInDetail {
  int get id => throw _privateConstructorUsedError;
  int get assign => throw _privateConstructorUsedError;
  DateTime get available_at => throw _privateConstructorUsedError;
  List<Reply>? get replies => throw _privateConstructorUsedError;
  int get day => throw _privateConstructorUsedError;
  bool get has_permission => throw _privateConstructorUsedError;
  bool get is_read => throw _privateConstructorUsedError;
  int get to => throw _privateConstructorUsedError;
  String get to_first_name => throw _privateConstructorUsedError;
  String? get to_image => throw _privateConstructorUsedError;
  int get by => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get is_latest => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MailInDetailCopyWith<MailInDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MailInDetailCopyWith<$Res> {
  factory $MailInDetailCopyWith(
          MailInDetail value, $Res Function(MailInDetail) then) =
      _$MailInDetailCopyWithImpl<$Res, MailInDetail>;
  @useResult
  $Res call(
      {int id,
      int assign,
      DateTime available_at,
      List<Reply>? replies,
      int day,
      bool has_permission,
      bool is_read,
      int to,
      String to_first_name,
      String? to_image,
      int by,
      String description,
      bool is_latest});
}

/// @nodoc
class _$MailInDetailCopyWithImpl<$Res, $Val extends MailInDetail>
    implements $MailInDetailCopyWith<$Res> {
  _$MailInDetailCopyWithImpl(this._value, this._then);

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
    Object? to = null,
    Object? to_first_name = null,
    Object? to_image = freezed,
    Object? by = null,
    Object? description = null,
    Object? is_latest = null,
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
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as int,
      to_first_name: null == to_first_name
          ? _value.to_first_name
          : to_first_name // ignore: cast_nullable_to_non_nullable
              as String,
      to_image: freezed == to_image
          ? _value.to_image
          : to_image // ignore: cast_nullable_to_non_nullable
              as String?,
      by: null == by
          ? _value.by
          : by // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      is_latest: null == is_latest
          ? _value.is_latest
          : is_latest // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MailInDetailImplCopyWith<$Res>
    implements $MailInDetailCopyWith<$Res> {
  factory _$$MailInDetailImplCopyWith(
          _$MailInDetailImpl value, $Res Function(_$MailInDetailImpl) then) =
      __$$MailInDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int assign,
      DateTime available_at,
      List<Reply>? replies,
      int day,
      bool has_permission,
      bool is_read,
      int to,
      String to_first_name,
      String? to_image,
      int by,
      String description,
      bool is_latest});
}

/// @nodoc
class __$$MailInDetailImplCopyWithImpl<$Res>
    extends _$MailInDetailCopyWithImpl<$Res, _$MailInDetailImpl>
    implements _$$MailInDetailImplCopyWith<$Res> {
  __$$MailInDetailImplCopyWithImpl(
      _$MailInDetailImpl _value, $Res Function(_$MailInDetailImpl) _then)
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
    Object? to = null,
    Object? to_first_name = null,
    Object? to_image = freezed,
    Object? by = null,
    Object? description = null,
    Object? is_latest = null,
  }) {
    return _then(_$MailInDetailImpl(
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
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as int,
      to_first_name: null == to_first_name
          ? _value.to_first_name
          : to_first_name // ignore: cast_nullable_to_non_nullable
              as String,
      to_image: freezed == to_image
          ? _value.to_image
          : to_image // ignore: cast_nullable_to_non_nullable
              as String?,
      by: null == by
          ? _value.by
          : by // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      is_latest: null == is_latest
          ? _value.is_latest
          : is_latest // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MailInDetailImpl implements _MailInDetail {
  _$MailInDetailImpl(
      {required this.id,
      required this.assign,
      required this.available_at,
      final List<Reply>? replies,
      required this.day,
      required this.has_permission,
      required this.is_read,
      required this.to,
      required this.to_first_name,
      this.to_image,
      required this.by,
      required this.description,
      required this.is_latest})
      : _replies = replies;

  factory _$MailInDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$MailInDetailImplFromJson(json);

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
  final int to;
  @override
  final String to_first_name;
  @override
  final String? to_image;
  @override
  final int by;
  @override
  final String description;
  @override
  final bool is_latest;

  @override
  String toString() {
    return 'MailInDetail(id: $id, assign: $assign, available_at: $available_at, replies: $replies, day: $day, has_permission: $has_permission, is_read: $is_read, to: $to, to_first_name: $to_first_name, to_image: $to_image, by: $by, description: $description, is_latest: $is_latest)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MailInDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.assign, assign) || other.assign == assign) &&
            (identical(other.available_at, available_at) ||
                other.available_at == available_at) &&
            const DeepCollectionEquality().equals(other._replies, _replies) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.has_permission, has_permission) ||
                other.has_permission == has_permission) &&
            (identical(other.is_read, is_read) || other.is_read == is_read) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.to_first_name, to_first_name) ||
                other.to_first_name == to_first_name) &&
            (identical(other.to_image, to_image) ||
                other.to_image == to_image) &&
            (identical(other.by, by) || other.by == by) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.is_latest, is_latest) ||
                other.is_latest == is_latest));
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
      is_read,
      to,
      to_first_name,
      to_image,
      by,
      description,
      is_latest);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MailInDetailImplCopyWith<_$MailInDetailImpl> get copyWith =>
      __$$MailInDetailImplCopyWithImpl<_$MailInDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MailInDetailImplToJson(
      this,
    );
  }
}

abstract class _MailInDetail implements MailInDetail {
  factory _MailInDetail(
      {required final int id,
      required final int assign,
      required final DateTime available_at,
      final List<Reply>? replies,
      required final int day,
      required final bool has_permission,
      required final bool is_read,
      required final int to,
      required final String to_first_name,
      final String? to_image,
      required final int by,
      required final String description,
      required final bool is_latest}) = _$MailInDetailImpl;

  factory _MailInDetail.fromJson(Map<String, dynamic> json) =
      _$MailInDetailImpl.fromJson;

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
  int get to;
  @override
  String get to_first_name;
  @override
  String? get to_image;
  @override
  int get by;
  @override
  String get description;
  @override
  bool get is_latest;
  @override
  @JsonKey(ignore: true)
  _$$MailInDetailImplCopyWith<_$MailInDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
