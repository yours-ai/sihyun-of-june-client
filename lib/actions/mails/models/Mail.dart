import 'package:json_annotation/json_annotation.dart';
import 'package:project_june_client/actions/mails/models/Replies.dart';

part 'Mail.g.dart';

@JsonSerializable()
class Mail {
  int id;
  num to;
  String to_full_name;
  num by;
  String by_full_name;
  String? by_image;
  String description;
  String available_at;
  bool is_read;
  List<RepliesBean>? replies;
  String? image;

  Mail(
      {required this.id,
      required this.to,
      required this.to_full_name,
      required this.by,
      required this.by_full_name,
      required this.by_image,
      required this.description,
      required this.available_at,
      required this.is_read,
      required this.replies,
      required this.image});

  factory Mail.fromJson(Map<String, dynamic> json) => _$MailFromJson(json);

  Map<String, dynamic> toJson() => _$MailToJson(this);
}
