import 'package:project_june_client/actions/client.dart';
import 'package:project_june_client/actions/mails/dtos.dart';
import 'package:project_june_client/actions/mails/models/MailInDetail.dart';
import 'package:project_june_client/actions/mails/models/MailInList.dart';
import 'package:project_june_client/services.dart';

import 'models/MailTicketInfo.dart';

Future<List<MailInList>> fetchMailList(int assignId) async {
  final response = await dio.get(
    '/mail/v4/character-sent-mails?character_selected_by_user_id=$assignId',
  );
  final rawMailList = response.data
      .map<MailInList>((json) => MailInList.fromJson(json))
      .toList();
  final mailList = mailService.validateAndFilterMails(rawMailList);
  return mailList;
}

Future<MailInDetail> fetchMailById(int id) async {
  final response = await dio.get(
    '/mail/v4/character-sent-mails/$id/',
  );
  return MailInDetail.fromJson(response.data);
}

Future<void> replyMail(ReplyMailDTO dto) async {
  await dio.post(
    '/mail/character-sent-mails/${dto.id}/reply/',
    data: {'description': dto.description},
  );
  return;
}

Future<void> readMail(int id) async {
  await dio.post(
    '/mail/character-sent-mails/$id/read/',
  );
  return;
}

Future<MailTicketInfo> fetchMailTicketInfo() async {
  final response = await dio.get('/mail/mail-ticket/information/');
  return MailTicketInfo.fromJson(response.data);
}

Future<void> buyMonthlyMailTicket(int assignId) async {
  await dio.post('/mail/monthly-mail-ticket/$assignId/');
  return;
}

Future<bool> checkMonthlyMailTicket(int assignId) async {
  final response =
      await dio.get('/mail/monthly-mail-ticket/possession/$assignId/');
  return response.data['possession'];
}

Future<void> buySingleMailTicket(int mailId) async {
  await dio.post('/mail/single-mail-ticket/$mailId/');
  return;
}
