
import 'package:flutter/foundation.dart';

@immutable
class ValidatedPhoneDTO {
  final String phone;
  final String countryCode;

  const ValidatedPhoneDTO({
    required this.phone,
    required this.countryCode,
  });
}

@immutable
class ValidatedAuthCodeDTO {
  final int authCode;
  final String countryCode;
  final String phone;

  const ValidatedAuthCodeDTO({
    required this.authCode,
    required this.countryCode,
    required this.phone,
  });
}

@immutable
class ValidatedUserDTO {
  final int authCode;
  final String countryCode;
  final String phone;
  final String? firstName;
  final String? lastName;

  const ValidatedUserDTO({
    required this.authCode,
    required this.countryCode,
    required this.phone,
    required this.firstName,
    required this.lastName,
  });
}
