import 'package:json_annotation/json_annotation.dart';
import 'package:project_june_client/actions/mails/models/Reply.dart';

part 'MailInList.g.dart';

@JsonSerializable()
class MailInList {
  int id;
  int assign;
  DateTime available_at;
  List<Reply>? replies;
  int days;
  bool has_permisson;

  MailInList(
      {required this.id,
      required this.assign,
      required this.available_at,
      required this.replies,
      required this.days,
      required this.has_permisson
      });

  factory MailInList.fromJson(Map<String, dynamic> json) => _$MailInListFromJson(json);

  Map<String, dynamic> toJson() => _$MailInListToJson(this);
}
