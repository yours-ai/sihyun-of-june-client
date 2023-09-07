import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:project_june_client/actions/character/actions.dart';
import 'package:project_june_client/actions/client.dart';

import 'models/Character.dart';
import 'models/Question.dart';

Query<List<Character>> getlistCharactersQuery() {
  return Query(
    key: ["characters"],
    queryFn: () => dio.get('/character/characters/').then(
      (response) {
        return response.data
            .map<Character>((json) => Character.fromJson(json))
            .toList();
      },
    ),
  );
}

Mutation<void, void> getQuestions({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, void>(
    queryFn: (void _) async {
      final questions = await fetchQuestions();
      List<Question> tabList = await questions;
    },
    onSuccess: onSuccess,
    onError: onError,
  );
}
