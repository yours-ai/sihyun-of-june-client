import 'package:flutter/foundation.dart';

@immutable
class UserFunnelDTO {
  final String? funnel;
  final String? refCode;

  const UserFunnelDTO({
    this.funnel,
    this.refCode,
  });
}
