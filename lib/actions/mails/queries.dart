import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:project_june_client/actions/mails/actions.dart';
import 'package:project_june_client/actions/mails/dtos.dart';
import 'package:project_june_client/actions/mails/models/MailInDetail.dart';
import 'package:project_june_client/actions/mails/models/MailTicketInfo.dart';

import 'models/MailInList.dart';

Query<List<MailInList>> fetchMailListQuery({
  OnQueryErrorCallback? onError,
  required int assignId,
}) {
  return Query<List<MailInList>>(
    key: 'character-sent-mail-list/$assignId',
    queryFn: () => fetchMailList(assignId),
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

Query<MailTicketInfo> fetchMailTicketInfoQuery({
  OnQueryErrorCallback? onError,
}) {
  return Query(
    key: 'mail-ticket-info',
    queryFn: fetchMailTicketInfo,
    onError: onError,
  );
}

Mutation<void, int> buyMonthlyMailTicketMutation({
  List<String> refetchQueries = const [],
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, int>(
    refetchQueries: refetchQueries,
    queryFn: buyMonthlyMailTicket,
    onSuccess: onSuccess,
    onError: onError,
  );
}

Query<bool> checkMonthlyMailTicketQuery({
  OnQueryErrorCallback? onError,
  required int assignId,
}) {
  return Query(
    key: 'monthly-mail-ticket/$assignId',
    queryFn: () => checkMonthlyMailTicket(assignId),
    onError: onError,
  );
}

Mutation<void, int> buySingleMailTicketMutation({
  List<String> refetchQueries = const [],
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, int>(
    refetchQueries: refetchQueries,
    queryFn: buySingleMailTicket,
    onSuccess: onSuccess,
    onError: onError,
  );
}
