import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_log.freezed.dart';

part 'transaction_log.g.dart';

@freezed
class TransactionLog with _$TransactionLog {
  factory TransactionLog({
    required num id,
    required String user,
    required String transaction_type,
    required num amount,
    required String description,
    required num balance,
    required String created,
  }) = _TransactionLog;

  factory TransactionLog.fromJson(Map<String, dynamic> json) =>
      _$TransactionLogFromJson(json);
}
