import 'package:json_annotation/json_annotation.dart';

import 'Reply.dart';

part 'Mail.g.dart';

@JsonSerializable()
class Mail {
  num id;
  String description;
  DateTime available_at;
  bool is_read;
  List<Reply> replies;
  String? image;

  Mail(
      {required this.id,
      required this.description,
      required this.available_at,
      required this.is_read,
      required this.replies,
      this.image});

  factory Mail.fromJson(Map<String, dynamic> json) => _$MailFromJson(json);

  Map<String, dynamic> toJson() => _$MailToJson(this);
}
