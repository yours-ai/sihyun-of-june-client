import 'package:project_june_client/actions/character/models/Character.dart';

import '../client.dart';
import 'models/Question.dart';

Future<List<Question>> fetchQuestions() async {
  final response = await dio.post('/character/test/start/');

  if (response.statusCode == 200) {
    return (response.data as List)
        .map<Question>((json) => Question.fromJson(json))
        .toList();
  } else {
    throw Exception('Failed to load questions');
  }
}

Future<Character> sendResponses(List<Map<String, dynamic>> responses) async {
  final response = await dio.post(
    '/character/test/end/',
    data: responses,
  );

  if (response.statusCode == 200) {
    return response.data
        .map<Character>((json) => Character.fromJson(json))
        .toList();
  } else {
    throw Exception('Failed to send questions');
  }
}
