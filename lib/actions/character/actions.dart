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
  final response = await dio.get('/character/test/status/');
  return response.data;
}

Future<Map<String, dynamic>> fetchPendingTest() async {
  final response = await dio.get('/character/v4/test/pending/');
  return response.data;
}

Future<void> confirmTest(int id) async {
  await dio.post('/character/test/$id/confirm/');
  return;
}

Future<List<Character>> fetchAllCharacters() async {
  final response = await dio.get('/character/v3/characters/');
  return (response.data as List).map((e) => Character.fromJson(e)).toList();
}

Future<void> denyTestChoice(int testId) async {
  await dio.post('/character/v3/test/$testId/deny/');
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

Future<void> reallocate(ReallocateDTO dto) async {
  await dio.post('/character/reallocate/',
      data: {'payment': dto.payment, 'method': dto.method});
  return;
}

Future<void> extend(String payment) async {
  await dio.post('/character/extend/', data: {'payment': payment});
  return;
}

Future<Map<String, int>> fetchExtendCost() async {
  final response = await dio.get('/character/extend/cost/');
  return {
    'coin': response.data['coin'] as int,
    'point': response.data['point'] as int,
  };
}

Future<Map<String, dynamic>> fetchIsNewUser() async {
  final response = await dio.get('/character/new-user-allocation/');
  return response.data;
}

Future<void> allocateForNewUser() async {
  await dio.post('/character/new-user-allocation/');
  return;
}

Future<void> confirmSelection(int selectionId, int characterId) async {
  await dio.post('/character/selection/$selectionId/confirm/',
      data: {'character_id': characterId});
  return;
}

Future<Map<String, dynamic>> fetchSelectionStatus() async {
  final response = await dio.get('/character/selection/status/');
  return response.data;
}
