import 'package:json_annotation/json_annotation.dart';

part 'MailTicketPrice.g.dart';

@JsonSerializable()
class MailTicketPrice {
  int single_mail_ticket_coin;
  int monthly_mail_ticket_coin;

  MailTicketPrice({
    required this.single_mail_ticket_coin,
    required this.monthly_mail_ticket_coin,
  });

  factory MailTicketPrice.fromJson(Map<String, dynamic> json) =>
      _$MailTicketPriceFromJson(json);

  Map<String, dynamic> toJson() => _$MailTicketPriceToJson(this);
}
