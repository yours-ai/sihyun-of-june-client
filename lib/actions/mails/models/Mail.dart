import 'package:json_annotation/json_annotation.dart';
import 'package:project_june_client/actions/mails/models/Reply.dart';

part 'Mail.g.dart';

@JsonSerializable()
class Mail {
  int id;
  num to;
  String to_full_name;
  num by;
  String by_full_name;
  String? by_image;
  String? to_image;
  String description;
  DateTime available_at;
  bool is_read;
  List<Reply>? replies;
  String? image;
  bool is_latest;

  Mail(
      {required this.id,
      required this.to,
      required this.to_full_name,
      required this.by,
      required this.by_full_name,
      required this.by_image,
      required this.to_image,
      required this.description,
      required this.available_at,
      required this.is_read,
      required this.replies,
      required this.image,
      required this.is_latest});

  factory Mail.fromJson(Map<String, dynamic> json) => _$MailFromJson(json);

  Map<String, dynamic> toJson() => _$MailToJson(this);
}
