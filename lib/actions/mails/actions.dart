import 'package:project_june_client/actions/client.dart';
import 'package:project_june_client/actions/mails/dtos.dart';
import 'package:project_june_client/actions/mails/models/Mail.dart';

Future<List<Mail>> fetchMailList() async {
  final response = await dio.get(
    '/mail/character-sent-mails/',
  );
  return response.data.map<Mail>((json) => Mail.fromJson(json)).toList();
}

Future<Mail> fetchMailById(int id) async {
  final response = await dio.get(
    '/mail/character-sent-mails/$id/',
  );
  return Mail.fromJson(response.data);
}

Future<void> replyMailById(ReplyMailDTO dto) async {
  await dio.post(
    '/mail/character-sent-mails/${dto.id}/reply/',
    data: {'description': dto.description},
  );
  return;
}

Future<void> readMailById(int id) async {
  await dio.post(
    '/mail/character-sent-mails/$id/read/',
  );
  return;
}
