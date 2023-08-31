import 'package:json_annotation/json_annotation.dart';

part 'Mail.g.dart';

@JsonSerializable()
class Mail {
  num id;
  String description;
  int available_at;
  bool is_read;
  List<Replies> replies;
  String image;

  Mail(
      {required this.id,
      required this.description,
      required this.available_at,
      required this.is_read,
      required this.replies,
      required this.image});

  factory Mail.fromJson(Map<String, dynamic> json) => _$MailFromJson(json);

  Map<String, dynamic> toJson() => _$MailToJson(this);
}

@JsonSerializable()
class Replies {
  num id;
  String description;
  int created;
  int modified;

  Replies(
      {required this.id,
      required this.description,
      required this.created,
      required this.modified});

  factory Replies.fromJson(Map<String, dynamic> json) =>
      _$RepliesFromJson(json);

  Map<String, dynamic> toJson() => _$RepliesToJson(this);
}
