import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:project_june_client/actions/mails/actions.dart';
import 'package:project_june_client/actions/mails/dtos.dart';

import 'models/Mail.dart';

Query<List<Mail>> getListMailQuery({OnQueryErrorCallback? onError}) {
  return Query<List<Mail>>(
    key: 'character-sent-mail-list',
    queryFn: fetchMailList,
    onError: onError,
  );
}

Query<Mail> getRetrieveMailQuery(
    {OnQueryErrorCallback? onError, required int id}) {
  return Query<Mail>(
    key: 'character-sent-mail/$id',
    queryFn: () => fetchMailById(id),
    onError: onError,
  );
}

Mutation<void, int> getReadMailMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, int>(
    queryFn: readMailById,
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<void, ReplyMailDTO> getSendMailReplyMutation({
  List<String> refetchQueries = const [],
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, ReplyMailDTO>(
    refetchQueries: refetchQueries,
    queryFn: replyMailById,
    onSuccess: onSuccess,
    onError: onError,
  );
}
