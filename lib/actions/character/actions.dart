import 'package:project_june_client/actions/character/dtos.dart';
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

Future<Map<String, dynamic>> fetchTestStatus() async {
  final response = await dio.get('/character/me/test-status/');
  return response.data;
}

Future<Map<String, dynamic>> fetchPendingTest() async {
  final response = await dio.get('/character/v3/test/pending/');
  return response.data;
}

Future<void> confirmChoice(int id) async {
  await dio.post('/character/test/$id/confirm/');
  return;
}

Future<List<Character>> fetchCharacters() async {
  final response = await dio.get('/character/v3/characters/');
  return (response.data as List).map((e) => Character.fromJson(e)).toList();
}

Future<void> denyChoice(denyChoiceDTO dto) async {
  await dio.post('/character/test/${dto.id}/deny/', data: {'payment': dto.payment});
  return;
}

Future<List<Character>> fetchMyCharacter() async {
  final response = await dio.get('/character/v3/me/characters/');
  return (response.data as List).map((e) => Character.fromJson(e)).toList();
}

Future<Character> fetchCharacterById(int id) async {
  final response = await dio.get('/character/v3/characters/$id/');
  return Character.fromJson(response.data);
}

Future<void> readCharacterStory(int id) async {
  await dio.post('/character/me/story/read/', data: {'character_id': id});
  return;
}

Future<void> retest(String payment) async {
  await dio.post('/character/test/retest/', data: {'payment': payment});
  return;
}
