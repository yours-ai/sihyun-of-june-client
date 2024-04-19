import 'package:project_june_client/actions/mails/models/mail_ticket_price.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'mail_ticket_info.freezed.dart';

part 'mail_ticket_info.g.dart';

@freezed
class MailTicketInfo with _$MailTicketInfo {
  factory MailTicketInfo({
    required int free_mail_read_days,
    required MailTicketPrice mail_ticket_prices,
  }) = _MailTicketInfo;

  factory MailTicketInfo.fromJson(Map<String, dynamic> json) =>
      _$MailTicketInfoFromJson(json);
}
