import 'package:json_annotation/json_annotation.dart';
import 'package:project_june_client/actions/mails/models/MailInList.dart';

part 'CharacterToday.g.dart';

@JsonSerializable()
class CharacterToday {
  String text;
  String weather;
  DateTime next_mail_available_at;
  bool is_next_mail_last;
  bool is_last_mail;
  bool is_just_replied;
  MailInList? mail;

  CharacterToday({
    required this.text,
    required this.weather,
    required this.next_mail_available_at,
    required this.is_next_mail_last,
    required this.is_last_mail,
    required this.is_just_replied,
    this.mail,
  });

  factory CharacterToday.fromJson(Map<String, dynamic> json) =>
      _$CharacterTodayFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterTodayToJson(this);
}

enum HomeEnum {
  thirtyDaysFinished,
  needReply,
  arrivedLastMail,
  arrivedNewMail,
  justReplied,
  willBeArrivedMail,
  willBeArrivedLastMail,
}
