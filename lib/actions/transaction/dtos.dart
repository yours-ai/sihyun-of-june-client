import 'package:flutter/foundation.dart';

@immutable
class GoogleVerificationDTO {
  final String orderId;
  final String productId;
  final String purchaseToken;

  const GoogleVerificationDTO({
    required this.orderId,
    required this.productId,
    required this.purchaseToken,
  });
}
