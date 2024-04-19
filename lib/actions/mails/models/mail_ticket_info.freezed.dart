// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mail_ticket_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MailTicketInfo _$MailTicketInfoFromJson(Map<String, dynamic> json) {
  return _MailTicketInfo.fromJson(json);
}

/// @nodoc
mixin _$MailTicketInfo {
  int get free_mail_read_days => throw _privateConstructorUsedError;
  MailTicketPrice get mail_ticket_prices => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MailTicketInfoCopyWith<MailTicketInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MailTicketInfoCopyWith<$Res> {
  factory $MailTicketInfoCopyWith(
          MailTicketInfo value, $Res Function(MailTicketInfo) then) =
      _$MailTicketInfoCopyWithImpl<$Res, MailTicketInfo>;
  @useResult
  $Res call({int free_mail_read_days, MailTicketPrice mail_ticket_prices});

  $MailTicketPriceCopyWith<$Res> get mail_ticket_prices;
}

/// @nodoc
class _$MailTicketInfoCopyWithImpl<$Res, $Val extends MailTicketInfo>
    implements $MailTicketInfoCopyWith<$Res> {
  _$MailTicketInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? free_mail_read_days = null,
    Object? mail_ticket_prices = null,
  }) {
    return _then(_value.copyWith(
      free_mail_read_days: null == free_mail_read_days
          ? _value.free_mail_read_days
          : free_mail_read_days // ignore: cast_nullable_to_non_nullable
              as int,
      mail_ticket_prices: null == mail_ticket_prices
          ? _value.mail_ticket_prices
          : mail_ticket_prices // ignore: cast_nullable_to_non_nullable
              as MailTicketPrice,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MailTicketPriceCopyWith<$Res> get mail_ticket_prices {
    return $MailTicketPriceCopyWith<$Res>(_value.mail_ticket_prices, (value) {
      return _then(_value.copyWith(mail_ticket_prices: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MailTicketInfoImplCopyWith<$Res>
    implements $MailTicketInfoCopyWith<$Res> {
  factory _$$MailTicketInfoImplCopyWith(_$MailTicketInfoImpl value,
          $Res Function(_$MailTicketInfoImpl) then) =
      __$$MailTicketInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int free_mail_read_days, MailTicketPrice mail_ticket_prices});

  @override
  $MailTicketPriceCopyWith<$Res> get mail_ticket_prices;
}

/// @nodoc
class __$$MailTicketInfoImplCopyWithImpl<$Res>
    extends _$MailTicketInfoCopyWithImpl<$Res, _$MailTicketInfoImpl>
    implements _$$MailTicketInfoImplCopyWith<$Res> {
  __$$MailTicketInfoImplCopyWithImpl(
      _$MailTicketInfoImpl _value, $Res Function(_$MailTicketInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? free_mail_read_days = null,
    Object? mail_ticket_prices = null,
  }) {
    return _then(_$MailTicketInfoImpl(
      free_mail_read_days: null == free_mail_read_days
          ? _value.free_mail_read_days
          : free_mail_read_days // ignore: cast_nullable_to_non_nullable
              as int,
      mail_ticket_prices: null == mail_ticket_prices
          ? _value.mail_ticket_prices
          : mail_ticket_prices // ignore: cast_nullable_to_non_nullable
              as MailTicketPrice,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MailTicketInfoImpl implements _MailTicketInfo {
  _$MailTicketInfoImpl(
      {required this.free_mail_read_days, required this.mail_ticket_prices});

  factory _$MailTicketInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MailTicketInfoImplFromJson(json);

  @override
  final int free_mail_read_days;
  @override
  final MailTicketPrice mail_ticket_prices;

  @override
  String toString() {
    return 'MailTicketInfo(free_mail_read_days: $free_mail_read_days, mail_ticket_prices: $mail_ticket_prices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MailTicketInfoImpl &&
            (identical(other.free_mail_read_days, free_mail_read_days) ||
                other.free_mail_read_days == free_mail_read_days) &&
            (identical(other.mail_ticket_prices, mail_ticket_prices) ||
                other.mail_ticket_prices == mail_ticket_prices));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, free_mail_read_days, mail_ticket_prices);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MailTicketInfoImplCopyWith<_$MailTicketInfoImpl> get copyWith =>
      __$$MailTicketInfoImplCopyWithImpl<_$MailTicketInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MailTicketInfoImplToJson(
      this,
    );
  }
}

abstract class _MailTicketInfo implements MailTicketInfo {
  factory _MailTicketInfo(
          {required final int free_mail_read_days,
          required final MailTicketPrice mail_ticket_prices}) =
      _$MailTicketInfoImpl;

  factory _MailTicketInfo.fromJson(Map<String, dynamic> json) =
      _$MailTicketInfoImpl.fromJson;

  @override
  int get free_mail_read_days;
  @override
  MailTicketPrice get mail_ticket_prices;
  @override
  @JsonKey(ignore: true)
  _$$MailTicketInfoImplCopyWith<_$MailTicketInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
