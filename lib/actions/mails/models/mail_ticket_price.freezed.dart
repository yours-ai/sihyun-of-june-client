// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mail_ticket_price.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MailTicketPrice _$MailTicketPriceFromJson(Map<String, dynamic> json) {
  return _MailTicketPrice.fromJson(json);
}

/// @nodoc
mixin _$MailTicketPrice {
  int get single_mail_ticket_coin => throw _privateConstructorUsedError;
  int get monthly_mail_ticket_coin => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MailTicketPriceCopyWith<MailTicketPrice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MailTicketPriceCopyWith<$Res> {
  factory $MailTicketPriceCopyWith(
          MailTicketPrice value, $Res Function(MailTicketPrice) then) =
      _$MailTicketPriceCopyWithImpl<$Res, MailTicketPrice>;
  @useResult
  $Res call({int single_mail_ticket_coin, int monthly_mail_ticket_coin});
}

/// @nodoc
class _$MailTicketPriceCopyWithImpl<$Res, $Val extends MailTicketPrice>
    implements $MailTicketPriceCopyWith<$Res> {
  _$MailTicketPriceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? single_mail_ticket_coin = null,
    Object? monthly_mail_ticket_coin = null,
  }) {
    return _then(_value.copyWith(
      single_mail_ticket_coin: null == single_mail_ticket_coin
          ? _value.single_mail_ticket_coin
          : single_mail_ticket_coin // ignore: cast_nullable_to_non_nullable
              as int,
      monthly_mail_ticket_coin: null == monthly_mail_ticket_coin
          ? _value.monthly_mail_ticket_coin
          : monthly_mail_ticket_coin // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MailTicketPriceImplCopyWith<$Res>
    implements $MailTicketPriceCopyWith<$Res> {
  factory _$$MailTicketPriceImplCopyWith(_$MailTicketPriceImpl value,
          $Res Function(_$MailTicketPriceImpl) then) =
      __$$MailTicketPriceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int single_mail_ticket_coin, int monthly_mail_ticket_coin});
}

/// @nodoc
class __$$MailTicketPriceImplCopyWithImpl<$Res>
    extends _$MailTicketPriceCopyWithImpl<$Res, _$MailTicketPriceImpl>
    implements _$$MailTicketPriceImplCopyWith<$Res> {
  __$$MailTicketPriceImplCopyWithImpl(
      _$MailTicketPriceImpl _value, $Res Function(_$MailTicketPriceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? single_mail_ticket_coin = null,
    Object? monthly_mail_ticket_coin = null,
  }) {
    return _then(_$MailTicketPriceImpl(
      single_mail_ticket_coin: null == single_mail_ticket_coin
          ? _value.single_mail_ticket_coin
          : single_mail_ticket_coin // ignore: cast_nullable_to_non_nullable
              as int,
      monthly_mail_ticket_coin: null == monthly_mail_ticket_coin
          ? _value.monthly_mail_ticket_coin
          : monthly_mail_ticket_coin // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MailTicketPriceImpl implements _MailTicketPrice {
  _$MailTicketPriceImpl(
      {required this.single_mail_ticket_coin,
      required this.monthly_mail_ticket_coin});

  factory _$MailTicketPriceImpl.fromJson(Map<String, dynamic> json) =>
      _$$MailTicketPriceImplFromJson(json);

  @override
  final int single_mail_ticket_coin;
  @override
  final int monthly_mail_ticket_coin;

  @override
  String toString() {
    return 'MailTicketPrice(single_mail_ticket_coin: $single_mail_ticket_coin, monthly_mail_ticket_coin: $monthly_mail_ticket_coin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MailTicketPriceImpl &&
            (identical(
                    other.single_mail_ticket_coin, single_mail_ticket_coin) ||
                other.single_mail_ticket_coin == single_mail_ticket_coin) &&
            (identical(
                    other.monthly_mail_ticket_coin, monthly_mail_ticket_coin) ||
                other.monthly_mail_ticket_coin == monthly_mail_ticket_coin));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, single_mail_ticket_coin, monthly_mail_ticket_coin);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MailTicketPriceImplCopyWith<_$MailTicketPriceImpl> get copyWith =>
      __$$MailTicketPriceImplCopyWithImpl<_$MailTicketPriceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MailTicketPriceImplToJson(
      this,
    );
  }
}

abstract class _MailTicketPrice implements MailTicketPrice {
  factory _MailTicketPrice(
      {required final int single_mail_ticket_coin,
      required final int monthly_mail_ticket_coin}) = _$MailTicketPriceImpl;

  factory _MailTicketPrice.fromJson(Map<String, dynamic> json) =
      _$MailTicketPriceImpl.fromJson;

  @override
  int get single_mail_ticket_coin;
  @override
  int get monthly_mail_ticket_coin;
  @override
  @JsonKey(ignore: true)
  _$$MailTicketPriceImplCopyWith<_$MailTicketPriceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
