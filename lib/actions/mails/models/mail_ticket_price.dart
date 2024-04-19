import 'package:freezed_annotation/freezed_annotation.dart';

part 'mail_ticket_price.freezed.dart';

part 'mail_ticket_price.g.dart';

@freezed
class MailTicketPrice with _$MailTicketPrice {
  factory MailTicketPrice({
    required int single_mail_ticket_coin,
    required int monthly_mail_ticket_coin,
  }) = _MailTicketPrice;

  factory MailTicketPrice.fromJson(Map<String, dynamic> json) =>
      _$MailTicketPriceFromJson(json);
}
