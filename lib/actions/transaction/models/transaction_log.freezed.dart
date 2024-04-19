// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TransactionLog _$TransactionLogFromJson(Map<String, dynamic> json) {
  return _TransactionLog.fromJson(json);
}

/// @nodoc
mixin _$TransactionLog {
  num get id => throw _privateConstructorUsedError;
  String get user => throw _privateConstructorUsedError;
  String get transaction_type => throw _privateConstructorUsedError;
  num get amount => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  num get balance => throw _privateConstructorUsedError;
  String get created => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionLogCopyWith<TransactionLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionLogCopyWith<$Res> {
  factory $TransactionLogCopyWith(
          TransactionLog value, $Res Function(TransactionLog) then) =
      _$TransactionLogCopyWithImpl<$Res, TransactionLog>;
  @useResult
  $Res call(
      {num id,
      String user,
      String transaction_type,
      num amount,
      String description,
      num balance,
      String created});
}

/// @nodoc
class _$TransactionLogCopyWithImpl<$Res, $Val extends TransactionLog>
    implements $TransactionLogCopyWith<$Res> {
  _$TransactionLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user = null,
    Object? transaction_type = null,
    Object? amount = null,
    Object? description = null,
    Object? balance = null,
    Object? created = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as num,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String,
      transaction_type: null == transaction_type
          ? _value.transaction_type
          : transaction_type // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as num,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionLogImplCopyWith<$Res>
    implements $TransactionLogCopyWith<$Res> {
  factory _$$TransactionLogImplCopyWith(_$TransactionLogImpl value,
          $Res Function(_$TransactionLogImpl) then) =
      __$$TransactionLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {num id,
      String user,
      String transaction_type,
      num amount,
      String description,
      num balance,
      String created});
}

/// @nodoc
class __$$TransactionLogImplCopyWithImpl<$Res>
    extends _$TransactionLogCopyWithImpl<$Res, _$TransactionLogImpl>
    implements _$$TransactionLogImplCopyWith<$Res> {
  __$$TransactionLogImplCopyWithImpl(
      _$TransactionLogImpl _value, $Res Function(_$TransactionLogImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user = null,
    Object? transaction_type = null,
    Object? amount = null,
    Object? description = null,
    Object? balance = null,
    Object? created = null,
  }) {
    return _then(_$TransactionLogImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as num,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String,
      transaction_type: null == transaction_type
          ? _value.transaction_type
          : transaction_type // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as num,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionLogImpl implements _TransactionLog {
  _$TransactionLogImpl(
      {required this.id,
      required this.user,
      required this.transaction_type,
      required this.amount,
      required this.description,
      required this.balance,
      required this.created});

  factory _$TransactionLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionLogImplFromJson(json);

  @override
  final num id;
  @override
  final String user;
  @override
  final String transaction_type;
  @override
  final num amount;
  @override
  final String description;
  @override
  final num balance;
  @override
  final String created;

  @override
  String toString() {
    return 'TransactionLog(id: $id, user: $user, transaction_type: $transaction_type, amount: $amount, description: $description, balance: $balance, created: $created)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.transaction_type, transaction_type) ||
                other.transaction_type == transaction_type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.created, created) || other.created == created));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, user, transaction_type,
      amount, description, balance, created);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionLogImplCopyWith<_$TransactionLogImpl> get copyWith =>
      __$$TransactionLogImplCopyWithImpl<_$TransactionLogImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionLogImplToJson(
      this,
    );
  }
}

abstract class _TransactionLog implements TransactionLog {
  factory _TransactionLog(
      {required final num id,
      required final String user,
      required final String transaction_type,
      required final num amount,
      required final String description,
      required final num balance,
      required final String created}) = _$TransactionLogImpl;

  factory _TransactionLog.fromJson(Map<String, dynamic> json) =
      _$TransactionLogImpl.fromJson;

  @override
  num get id;
  @override
  String get user;
  @override
  String get transaction_type;
  @override
  num get amount;
  @override
  String get description;
  @override
  num get balance;
  @override
  String get created;
  @override
  @JsonKey(ignore: true)
  _$$TransactionLogImplCopyWith<_$TransactionLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
