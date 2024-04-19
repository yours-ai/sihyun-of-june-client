import 'package:project_june_client/actions/mails/models/mail_in_list.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_today.freezed.dart';

part 'character_today.g.dart';

@freezed
class CharacterToday with _$CharacterToday {
  factory CharacterToday({
    required String text,
    required String weather,
    required DateTime next_mail_available_at,
    required bool is_next_mail_last,
    required bool is_last_mail,
    required bool is_just_replied,
    MailInList? mail,
  }) = _CharacterToday;

  factory CharacterToday.fromJson(Map<String, dynamic> json) =>
      _$CharacterTodayFromJson(json);
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
