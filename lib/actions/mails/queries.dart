import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:project_june_client/actions/mails/actions.dart';
import 'package:project_june_client/actions/mails/dtos.dart';
import 'package:project_june_client/actions/mails/models/MailInDetail.dart';

import 'models/MailInList.dart';

Query<List<MailInList>> fetchMailListQuery({
  OnQueryErrorCallback? onError,
  required int assignedId,
}) {
  return Query<List<MailInList>>(
    key: 'character-sent-mail-list/$assignedId',
    queryFn: () => fetchMailList(assignedId),
    onError: onError,
  );
}

Query<MailInDetail> fetchMailByIdQuery(
    {OnQueryErrorCallback? onError, required int id}) {
  return Query<MailInDetail>(
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
