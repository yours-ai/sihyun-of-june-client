import 'package:json_annotation/json_annotation.dart';

part 'CoinLog.g.dart';

@JsonSerializable()
class CoinLog {
  num id;
  String user;
  String transaction_type;
  num amount;
  String description;
  num balance;
  String created;

  CoinLog(
      {required this.id,
      required this.user,
      required this.transaction_type,
      required this.amount,
      required this.description,
      required this.balance,
      required this.created});

  factory CoinLog.fromJson(Map<String, dynamic> json) =>
      _$CoinLogFromJson(json);

  Map<String, dynamic> toJson() => _$CoinLogToJson(this);
}
