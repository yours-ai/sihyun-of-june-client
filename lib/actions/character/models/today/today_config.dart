import 'package:project_june_client/actions/mails/models/mail_in_list.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'today_config.freezed.dart';

part 'today_config.g.dart';

@freezed
class TodayConfig with _$TodayConfig {
  factory TodayConfig({
    required DateTime next_mail_available_at,
    required bool is_next_mail_last,
    required bool is_last_mail,
    required bool is_just_replied,
    MailInList? mail,
  }) = _TodayConfig;

  factory TodayConfig.fromJson(Map<String, dynamic> json) =>
      _$TodayConfigFromJson(json);
}
