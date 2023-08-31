import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:project_june_client/actions/client.dart';

import 'models/Mail.dart';

Query<List<Mail>> getlistMailsQuery() {
  return Query(
    key: ["mails"],
    queryFn: () => dio.get('/mail/character-sent-mails/').then((response) {
      return response.data
          .map<Mail>((json) => Mail.fromJson(json))
          .toList();
    }),
  );
}
