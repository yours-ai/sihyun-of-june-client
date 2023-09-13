import 'package:flutter/foundation.dart';

@immutable
class ReplyMailDTO {
  final int id;
  final String description;

  const ReplyMailDTO({
    required this.id,
    required this.description,
  });
}