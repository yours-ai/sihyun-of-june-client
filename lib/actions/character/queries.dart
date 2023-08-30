import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:project_june_client/actions/client.dart';

import 'models/Character.dart';

Query<List<Character>> getlistCharactersQuery() {
  return Query(
    key: ["characters"],
    queryFn: () => dio.get('/character/characters/').then((response) {
      return response.data
          .map<Character>((json) => Character.fromJson(json))
          .toList();
    }),
  );
}
