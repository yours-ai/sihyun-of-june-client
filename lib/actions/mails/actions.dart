import 'package:project_june_client/actions/client.dart';
import 'package:project_june_client/actions/mails/dtos.dart';
import 'package:project_june_client/actions/mails/models/MailInDetail.dart';
import 'package:project_june_client/actions/mails/models/MailInList.dart';

Future<List<MailInList>> fetchMailList(int assignedId) async {
  final response = await dio.get(
    '/mail/v4/character-sent-mails?character_selected_by_user_id=$assignedId',
  );
  return response.data
      .map<MailInList>((json) => MailInList.fromJson(json))
      .toList();
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
