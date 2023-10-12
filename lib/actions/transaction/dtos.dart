import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

@immutable
class GoogleVerificationDTO {
  final String orderId;
  final String productId;
  final String purchaseToken;

  GoogleVerificationDTO({
    required this.orderId,
    required this.productId,
    required this.purchaseToken,
  });
}
