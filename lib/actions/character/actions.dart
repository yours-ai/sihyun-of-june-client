import 'package:project_june_client/actions/character/models/Character.dart';

import '../client.dart';

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


Future<void> confirmChoice(int id) async {
  final response = await dio.post('/character/test/$id/confirm/');
  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception('Failed to confirm choice');
  }
}

Future<void> denyChoice(int id) async {
  final response = await dio.post('/character/test/$id/deny/');
  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception('Failed to confirm choice');
  }
}

Future<List<Character>> fetchCharacter() async {
  final response = await dio.get('/character/me/characters/');

  if (response.statusCode == 200) {
    return (response.data as List).map((e) => Character.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load character');
  }
}
