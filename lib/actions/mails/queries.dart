import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:project_june_client/actions/mails/actions.dart';
import 'package:project_june_client/actions/mails/dtos.dart';

import 'models/Mail.dart';

Query<List<Mail>> getMailListQuery({OnQueryErrorCallback? onError}) {
  return Query<List<Mail>>(
    key: ['character-sent-mails'],
    queryFn: fetchMailList,
    onError: onError,
  );
}

Query<Mail> getMailQuery({OnQueryErrorCallback? onError, required int id}) {
  return Query<Mail>(
    key: ['character-sent-mail', id],
    queryFn: () => fetchMailById(id),
    onError: onError,
  );
}

Mutation<void, int> getSendMailReadMutation({
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
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, ReplyMailDTO>(
    queryFn: replyMailById,
    onSuccess: onSuccess,
    onError: onError,
  );
}
