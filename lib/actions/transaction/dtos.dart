import 'package:flutter/foundation.dart';

@immutable
class CoinTradeDTO {
  final String transactionType;
  final int amount;
  final description;

  const CoinTradeDTO({
    required this.transactionType,
    required this.amount,
    required this.description
  });
}