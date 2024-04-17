import 'package:json_annotation/json_annotation.dart';
import 'package:project_june_client/actions/mails/models/MailInList.dart';

part 'TodayConfig.g.dart';

@JsonSerializable()
class TodayConfig {
  DateTime next_mail_available_at;
  bool is_next_mail_last;
  bool is_last_mail;
  bool is_just_replied;
  MailInList? mail;

  TodayConfig({
    required this.next_mail_available_at,
    required this.is_next_mail_last,
    required this.is_last_mail,
    required this.is_just_replied,
    this.mail,
  });

  factory TodayConfig.fromJson(Map<String, dynamic> json) =>
      _$TodayConfigFromJson(json);

  Map<String, dynamic> toJson() => _$TodayConfigToJson(this);
}
