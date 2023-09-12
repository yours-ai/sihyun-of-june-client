import 'package:project_june_client/actions/character/models/Character.dart';

import '../client.dart';
import 'models/Question.dart';

Future<void> sendResponses(List<Map<String, dynamic>> responses) async {
  final response = await dio.post(
    '/character/test/end/',
    data: responses,
  );

  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception('Failed to send responses');
  }
}


Future<void> confirmChoice(num id) async {
  final response = await dio.post('/character/test/$id/confirm/');
  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception('Failed to confirm choice');
  }
}

Future<void> denyChoice(num id) async {
  final response = await dio.post('/character/test/$id/deny/');
  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception('Failed to confirm choice');
  }
}

Future<Character> fetchCharacter() async {
  final response = await dio.get('/me/character/');

  if (response.statusCode == 200) {
    return Character.fromJson(response.data);
  } else {
    throw Exception('Failed to load character');
  }
}
