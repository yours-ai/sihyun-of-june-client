import 'package:json_annotation/json_annotation.dart';
import 'package:project_june_client/actions/mails/models/MailTicketPrice.dart';

part 'MailTicketInfo.g.dart';

@JsonSerializable()
class MailTicketInfo {
  int free_mail_read_days;
  MailTicketPrice mail_ticket_prices;

  MailTicketInfo({
    required this.free_mail_read_days,
    required this.mail_ticket_prices,
  });

  factory MailTicketInfo.fromJson(Map<String, dynamic> json) =>
      _$MailTicketInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MailTicketInfoToJson(this);
}
