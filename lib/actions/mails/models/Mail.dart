import 'package:json_annotation/json_annotation.dart';
import 'package:project_june_client/actions/mails/models/Reply.dart';

part 'Mail.g.dart';

@JsonSerializable()
class Mail {
  int id;
  int to;
  String to_first_name;
  int by;
  String? to_image;
  String description;
  DateTime available_at;
  bool is_read;
  List<Reply>? replies;
  bool is_latest;
  bool is_first_reply;

  Mail(
      {required this.id,
      required this.to,
      required this.to_first_name,
      required this.by,
      required this.to_image,
      required this.description,
      required this.available_at,
      required this.is_read,
      required this.replies,
      required this.is_latest,
      required this.is_first_reply
      });

  factory Mail.fromJson(Map<String, dynamic> json) => _$MailFromJson(json);

  Map<String, dynamic> toJson() => _$MailToJson(this);
}
