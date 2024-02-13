import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:project_june_client/actions/mails/actions.dart';
import 'package:project_june_client/actions/mails/dtos.dart';

import 'models/Mail.dart';

Query<List<Mail>> fetchMailListQuery(
    {OnQueryErrorCallback? onError,
    required int characterId,
    required int page}) {
  return Query<List<Mail>>(
    key: 'character-sent-mail-list/$characterId/$page',
    queryFn: () => fetchMailList(characterId: characterId, page: page),
    onError: onError,
  );
}

Query<Mail> fetchMailByIdQuery(
    {OnQueryErrorCallback? onError, required int id}) {
  return Query<Mail>(
    key: 'character-sent-mail/$id',
    queryFn: () => fetchMailById(id),
    onError: onError,
  );
}

Mutation<void, int> readMailMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, int>(
    queryFn: readMail,
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<void, ReplyMailDTO> replyMailMutation({
  List<String> refetchQueries = const [],
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, ReplyMailDTO>(
    refetchQueries: refetchQueries,
    queryFn: replyMail,
    onSuccess: onSuccess,
    onError: onError,
  );
}
