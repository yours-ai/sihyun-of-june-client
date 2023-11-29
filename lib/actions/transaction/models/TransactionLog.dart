import 'package:json_annotation/json_annotation.dart';

part 'TransactionLog.g.dart';

@JsonSerializable()
class TransactionLog {
  num id;
  String user;
  String transaction_type;
  num amount;
  String description;
  num balance;
  String created;

  TransactionLog(
      {required this.id,
      required this.user,
      required this.transaction_type,
      required this.amount,
      required this.description,
      required this.balance,
      required this.created});

  factory TransactionLog.fromJson(Map<String, dynamic> json) =>
      _$TransactionLogFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionLogToJson(this);
}
