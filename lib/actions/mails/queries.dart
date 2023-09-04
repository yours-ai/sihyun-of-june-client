import 'package:cached_query_flutter/cached_query_flutter.dart';

import '../client.dart';
import 'models/Mail.dart';

Query<List<Mail>> getMailListQuery() {
  return Query<List<Mail>>(
    key: ['character-sent-mails'],
    queryFn: () => dio.get('/mail/character-sent-mails/').then(
          (res) => res.data.map<Mail>((json) => Mail.fromJson(json)).toList(),
        ),
  );
}
