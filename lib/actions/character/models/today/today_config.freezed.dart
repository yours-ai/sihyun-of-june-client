// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'today_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TodayConfig _$TodayConfigFromJson(Map<String, dynamic> json) {
  return _TodayConfig.fromJson(json);
}

/// @nodoc
mixin _$TodayConfig {
  DateTime get next_mail_available_at => throw _privateConstructorUsedError;
  bool get is_next_mail_last => throw _privateConstructorUsedError;
  bool get is_last_mail => throw _privateConstructorUsedError;
  bool get is_just_replied => throw _privateConstructorUsedError;
  MailInList? get mail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodayConfigCopyWith<TodayConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodayConfigCopyWith<$Res> {
  factory $TodayConfigCopyWith(
          TodayConfig value, $Res Function(TodayConfig) then) =
      _$TodayConfigCopyWithImpl<$Res, TodayConfig>;
  @useResult
  $Res call(
      {DateTime next_mail_available_at,
      bool is_next_mail_last,
      bool is_last_mail,
      bool is_just_replied,
      MailInList? mail});

  $MailInListCopyWith<$Res>? get mail;
}

/// @nodoc
class _$TodayConfigCopyWithImpl<$Res, $Val extends TodayConfig>
    implements $TodayConfigCopyWith<$Res> {
  _$TodayConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? next_mail_available_at = null,
    Object? is_next_mail_last = null,
    Object? is_last_mail = null,
    Object? is_just_replied = null,
    Object? mail = freezed,
  }) {
    return _then(_value.copyWith(
      next_mail_available_at: null == next_mail_available_at
          ? _value.next_mail_available_at
          : next_mail_available_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      is_next_mail_last: null == is_next_mail_last
          ? _value.is_next_mail_last
          : is_next_mail_last // ignore: cast_nullable_to_non_nullable
              as bool,
      is_last_mail: null == is_last_mail
          ? _value.is_last_mail
          : is_last_mail // ignore: cast_nullable_to_non_nullable
              as bool,
      is_just_replied: null == is_just_replied
          ? _value.is_just_replied
          : is_just_replied // ignore: cast_nullable_to_non_nullable
              as bool,
      mail: freezed == mail
          ? _value.mail
          : mail // ignore: cast_nullable_to_non_nullable
              as MailInList?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MailInListCopyWith<$Res>? get mail {
    if (_value.mail == null) {
      return null;
    }

    return $MailInListCopyWith<$Res>(_value.mail!, (value) {
      return _then(_value.copyWith(mail: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TodayConfigImplCopyWith<$Res>
    implements $TodayConfigCopyWith<$Res> {
  factory _$$TodayConfigImplCopyWith(
          _$TodayConfigImpl value, $Res Function(_$TodayConfigImpl) then) =
      __$$TodayConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime next_mail_available_at,
      bool is_next_mail_last,
      bool is_last_mail,
      bool is_just_replied,
      MailInList? mail});

  @override
  $MailInListCopyWith<$Res>? get mail;
}

/// @nodoc
class __$$TodayConfigImplCopyWithImpl<$Res>
    extends _$TodayConfigCopyWithImpl<$Res, _$TodayConfigImpl>
    implements _$$TodayConfigImplCopyWith<$Res> {
  __$$TodayConfigImplCopyWithImpl(
      _$TodayConfigImpl _value, $Res Function(_$TodayConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? next_mail_available_at = null,
    Object? is_next_mail_last = null,
    Object? is_last_mail = null,
    Object? is_just_replied = null,
    Object? mail = freezed,
  }) {
    return _then(_$TodayConfigImpl(
      next_mail_available_at: null == next_mail_available_at
          ? _value.next_mail_available_at
          : next_mail_available_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      is_next_mail_last: null == is_next_mail_last
          ? _value.is_next_mail_last
          : is_next_mail_last // ignore: cast_nullable_to_non_nullable
              as bool,
      is_last_mail: null == is_last_mail
          ? _value.is_last_mail
          : is_last_mail // ignore: cast_nullable_to_non_nullable
              as bool,
      is_just_replied: null == is_just_replied
          ? _value.is_just_replied
          : is_just_replied // ignore: cast_nullable_to_non_nullable
              as bool,
      mail: freezed == mail
          ? _value.mail
          : mail // ignore: cast_nullable_to_non_nullable
              as MailInList?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TodayConfigImpl implements _TodayConfig {
  _$TodayConfigImpl(
      {required this.next_mail_available_at,
      required this.is_next_mail_last,
      required this.is_last_mail,
      required this.is_just_replied,
      this.mail});

  factory _$TodayConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodayConfigImplFromJson(json);

  @override
  final DateTime next_mail_available_at;
  @override
  final bool is_next_mail_last;
  @override
  final bool is_last_mail;
  @override
  final bool is_just_replied;
  @override
  final MailInList? mail;

  @override
  String toString() {
    return 'TodayConfig(next_mail_available_at: $next_mail_available_at, is_next_mail_last: $is_next_mail_last, is_last_mail: $is_last_mail, is_just_replied: $is_just_replied, mail: $mail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodayConfigImpl &&
            (identical(other.next_mail_available_at, next_mail_available_at) ||
                other.next_mail_available_at == next_mail_available_at) &&
            (identical(other.is_next_mail_last, is_next_mail_last) ||
                other.is_next_mail_last == is_next_mail_last) &&
            (identical(other.is_last_mail, is_last_mail) ||
                other.is_last_mail == is_last_mail) &&
            (identical(other.is_just_replied, is_just_replied) ||
                other.is_just_replied == is_just_replied) &&
            (identical(other.mail, mail) || other.mail == mail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, next_mail_available_at,
      is_next_mail_last, is_last_mail, is_just_replied, mail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TodayConfigImplCopyWith<_$TodayConfigImpl> get copyWith =>
      __$$TodayConfigImplCopyWithImpl<_$TodayConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodayConfigImplToJson(
      this,
    );
  }
}

abstract class _TodayConfig implements TodayConfig {
  factory _TodayConfig(
      {required final DateTime next_mail_available_at,
      required final bool is_next_mail_last,
      required final bool is_last_mail,
      required final bool is_just_replied,
      final MailInList? mail}) = _$TodayConfigImpl;

  factory _TodayConfig.fromJson(Map<String, dynamic> json) =
      _$TodayConfigImpl.fromJson;

  @override
  DateTime get next_mail_available_at;
  @override
  bool get is_next_mail_last;
  @override
  bool get is_last_mail;
  @override
  bool get is_just_replied;
  @override
  MailInList? get mail;
  @override
  @JsonKey(ignore: true)
  _$$TodayConfigImplCopyWith<_$TodayConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
