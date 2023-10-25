import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/character/models/Question.dart';

import '../client.dart';

Future<void> sendResponses(List<Map<String, int>> responses) async =>
    await dio.post(
      '/character/test/end/',
      data: responses,
    );

Future<List<Question>> startTest() async {
  final response = await dio.post('/character/test/start/');
  return response.data
      .map<Question>((json) => Question.fromJson(json))
      .toList();
}

Future<String> fetchTestStatus() async {
  final response = await dio.get('/character/me/test-status/');
  return response.data['status'];
}

Future<Map<String, dynamic>> fetchPendingTest() async {
  final response = await dio.get('/character/test/pending/');
  return response.data;
}

Future<void> confirmChoice(int id) async {
  await dio.post('/character/test/$id/confirm/');
  return;
}

Future<List<Character>> fetchCharacters() async {
  final response = await dio.get('/character/characters/');
  return (response.data as List).map((e) => Character.fromJson(e)).toList();
}

Future<void> denyChoice(int id) async {
  await dio.post('/character/test/$id/deny/');
  return;
}

Future<List<Character>> fetchMyCharacter() async {
  final response = await dio.get('/character/me/characters/');
  return (response.data as List).map((e) => Character.fromJson(e)).toList();
}

Future<Character> fetchCharacterById(int id) async {
  final response = await dio.get('/character/characters/$id/');
  return Character.fromJson(response.data);
}
