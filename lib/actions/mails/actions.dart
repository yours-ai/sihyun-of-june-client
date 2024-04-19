import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_june_client/actions/client.dart';
import 'package:project_june_client/actions/mails/models/mail_in_detail.dart';
import 'package:project_june_client/actions/mails/models/mail_in_list.dart';
import 'package:project_june_client/actions/mails/models/mail_ticket_info.dart';
import 'package:project_june_client/globals.dart';
import 'package:project_june_client/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'actions.g.dart';

@riverpod
FutureOr<List<MailInList>> mailList(MailListRef ref, int assignId) async {
  ref.watch(monthlyMailTicketProvider(assignId));

  final response = await dio.get(
    '/mail/v4/character-sent-mails?character_selected_by_user_id=$assignId',
  );
  final rawMailList = response.data
      .map<MailInList>((json) => MailInList.fromJson(json))
      .toList();
  final mailList = mailService.validateAndFilterMails(rawMailList);
  return mailList;
}

@riverpod
class Mail extends _$Mail {
  @override
  FutureOr<MailInDetail> build(int id) async {
    final response = await dio.get(
      '/mail/v4/character-sent-mails/${this.id}/',
    );
    return MailInDetail.fromJson(response.data);
  }

  FutureOr<void> reply(
    String description,
    Future<void> Function() onSuccess,
  ) async {
    try {
      await dio.post(
        '/mail/character-sent-mails/$id/reply/',
        data: {'description': description},
      );
      await onSuccess();
      ref.invalidateSelf();
      await future;
    } catch (error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text('답장을 보내지 못했습니다. 에러가 계속되면 고객센터에 문의해주세요.'),
        ),
      );
    }
  }

  FutureOr<void> readMail() async {
    try {
      await dio.post(
        '/mail/character-sent-mails/$id/read/',
      );
    } catch (error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text('메일을 읽지 못했습니다. 에러가 계속되면 고객센터에 문의해주세요.'),
        ),
      );
    }
  }
}

@riverpod
FutureOr<MailTicketInfo> mailTicketInfo(MailTicketInfoRef ref) async {
  final response = await dio.get('/mail/mail-ticket/information/');
  return MailTicketInfo.fromJson(response.data);
}

@riverpod
class MonthlyMailTicket extends _$MonthlyMailTicket {
  @override
  FutureOr<bool> build(int assignId) async {
    final response =
        await dio.get('/mail/monthly-mail-ticket/possession/${this.assignId}/');
    return response.data['possession'];
  }

  FutureOr<void> buy(
    BuildContext context, {
    required VoidCallback onSuccess,
  }) async {
    try {
      await dio.post('/mail/monthly-mail-ticket/$assignId/');
      onSuccess();
      ref.invalidateSelf();
      await future;
    } catch (error) {
      transactionService.throwBuyTicketError(error, context);
    }
  }
}

@riverpod
Future<void> buySingleMailTicket(
  BuySingleMailTicketRef ref,
  int mailId, {
  required Future<void> Function() onSuccess,
  required BuildContext context,
}) async {
  try {
    await dio.post('/mail/single-mail-ticket/$mailId/');
    await onSuccess();
  } catch (error) {
    transactionService.throwBuyTicketError(error, context);
  }
}
