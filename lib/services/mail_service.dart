import 'dart:math';

import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/actions/character/models/CharacterColors.dart';
import 'package:project_june_client/actions/mails/models/MailInDetail.dart';
import 'package:project_june_client/actions/mails/models/MailInList.dart';
import 'package:project_june_client/actions/mails/models/MailTicketInfo.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/contrib/flutter_secure_storage.dart';
import 'package:project_june_client/screens/mail/mail_detail_screen.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/mail_list/mail_widget.dart';

extension TimeOfDayExtension on TimeOfDay {
  int compareTo(TimeOfDay other) {
    if (hour < other.hour) return -1;
    if (hour > other.hour) return 1;
    if (minute < other.minute) return -1;
    if (minute > other.minute) return 1;
    return 0;
  }
}

class MailService {
  const MailService();

  String getFirstMailReceiveTimeStr() {
    TimeOfDay now = TimeOfDay.fromDateTime(clock.now());
    if (now.compareTo(ProjectConstants.mailReceiveTime) >= 0) {
      return '내일 저녁 9시';
    }
    return '오늘 저녁 9시';
  }

  String getNextMailReceiveTimeStr(DateTime availableAt) {
    final now = clock.now();
    final diff = availableAt.difference(now).inHours;
    if (diff < ProjectConstants.mailReceiveTime.hour) {
      return '오늘 저녁 9시';
    } else {
      return '내일 저녁 9시';
    }
  }

  int getMailDateDiff(DateTime targetDate, DateTime firstMailDate) {
    DateTime normalizedDt =
        DateTime(targetDate.year, targetDate.month, targetDate.day);
    DateTime normalizedFirstMailDate =
        DateTime(firstMailDate.year, firstMailDate.month, firstMailDate.day);
    return normalizedDt.difference(normalizedFirstMailDate).inDays;
  }

  String getDDay(DateTime startDate) {
    final goneDates = getMailDateDiff(clock.now(), startDate);
    if (goneDates >= 29) {
      return '마지막 날';
    }
    return 'D-${30 - goneDates}';
  }

  String getMailReceiveDateStr(DateTime targetDate, bool needMonth) {
    if (needMonth || targetDate.day == 1) {
      return DateFormat('M월 d일').format(targetDate);
    }
    return DateFormat('d').format(targetDate);
  }

  String formatMailDate(DateTime dt) {
    return DateFormat('yyyy.MM.dd').format(dt);
  }

  List<Widget> getEmptyCells(DateTime firstDate) {
    return List.generate(
        (firstDate.weekday - DateTime.sunday) % 7, (index) => const SizedBox());
  }

  Widget calendarWeekday() {
    final List<String> weekdays = [
      'Sun',
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat'
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        for (var day in weekdays)
          Expanded(
            child: Text(
              day,
              textScaler: TextScaler.noScaling,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorConstants.gray,
                fontWeight: FontWeightConstants.semiBold,
              ),
            ),
          ),
      ],
    );
  }

  String makePageLabel(index) {
    switch (index) {
      case 1:
        return '첫 번째 장';
      case 2:
        return '두 번째 장';
      case 3:
        return '세 번째 장';
      case 4:
        return '네 번째 장';
      case 5:
        return '다섯 번째 장';
      case 6:
        return '여섯 번째 장';
      case 7:
        return '일곱 번째 장';
      case 8:
        return '여덟 번째 장';
      case 9:
        return '아홉 번째 장';
      case 10:
        return '열 번째 장';
      case 11:
        return '열한 번째 장';
    }
    return '';
  }

  void getBeforeReply({
    required TextEditingController controller,
    required int mailId,
  }) async {
    final storage = getSecureStorage();
    final beforeReply =
        await storage.read(key: '${StorageKeyConstants.mailReply}_$mailId');
    if (beforeReply != null) {
      controller.text = beforeReply;
    }
  }

  Future<void> saveBeforeReply({
    required String reply,
    required int mailId,
  }) async {
    final storage = getSecureStorage();
    await storage.write(
        key: '${StorageKeyConstants.mailReply}_$mailId', value: reply);
  }

  Future<void> deleteBeforeReply(int mailId) async {
    final storage = getSecureStorage();
    await storage.delete(key: '${StorageKeyConstants.mailReply}_$mailId');
  }

  int checkMailNumber(
      DateTime firstMailAvailableAt, DateTime lastMailAvailableAt) {
    final totalMailNumber =
        getMailDateDiff(lastMailAvailableAt, firstMailAvailableAt) + 1;
    return totalMailNumber;
  }

  List<Widget> makeMailWidgetList({
    required List<MailInList> mails,
    required MailTicketInfo mailTicketInfo,
    required CharacterColors characterColors,
    required int assignId,
    required bool hasMonthlyMailTicket,
  }) {
    if (mails.isEmpty) {
      return [];
    }
    final firstMailAvailableAt = mails.last.available_at;
    final lastMail = mails.first;
    final lastMailAvailableAt = lastMail.available_at;
    final lastMailDay = lastMail.day;
    final mailCount =
        checkMailNumber(firstMailAvailableAt, lastMailAvailableAt);
    List<MailWidget> modifiedMailList = makeEmptyMailList(
      firstMailAvailableAt: firstMailAvailableAt,
      mailCount: mailCount,
      lastMailDay: lastMailDay,
      assignId: assignId,
      characterColors: characterColors,
      mailTicketInfo: mailTicketInfo,
      hasMonthlyMailTicket: hasMonthlyMailTicket,
    );
    for (var mail in mails) {
      modifiedMailList[mail.day - 1].mail = mail;
      modifiedMailList[mail.day - 1].hasPermission = mail.has_permission;
    }
    return fillMailList(modifiedMailList, firstMailAvailableAt);
  }

  List<MailWidget> makeEmptyMailList({
    required DateTime firstMailAvailableAt,
    required int mailCount,
    required int lastMailDay,
    required CharacterColors characterColors,
    required MailTicketInfo mailTicketInfo,
    required int assignId,
    required bool hasMonthlyMailTicket,
  }) {
    List<MailWidget> emptyMailList = [];
    final limitMailCount = mailCount <= 30 ? 30 : mailCount;
    emptyMailList = List.generate(
      mailTicketInfo.free_mail_read_days,
      (index) => MailWidget(
        mailIndex: index,
        firstMailDate: firstMailAvailableAt,
        hasPermission: true,
        isFuture: lastMailDay < index + 1 ? true : false,
        characterColors: characterColors,
        mailTicketInfo: mailTicketInfo,
        assignId: assignId,
      ),
    );
    emptyMailList.addAll(
      List.generate(
        limitMailCount - mailTicketInfo.free_mail_read_days,
        (index) => MailWidget(
          mailIndex: index + mailTicketInfo.free_mail_read_days,
          firstMailDate: firstMailAvailableAt,
          hasPermission: hasMonthlyMailTicket
              ? true
              : lastMailDay > mailTicketInfo.free_mail_read_days
                  ? false
                  : true,
          isFuture: lastMailDay < index + mailTicketInfo.free_mail_read_days + 1
              ? true
              : false,
          characterColors: characterColors,
          mailTicketInfo: mailTicketInfo,
          assignId: assignId,
        ),
      ),
    );
    return emptyMailList;
  }

  List<Widget> fillMailList(
      List<Widget> modifiedWidgetList, DateTime firstMailDate) {
    List<Widget> emptyCellsForWeekDay =
        getEmptyCells(firstMailDate); //첫 번째 날짜의 요일에 따라 빈 칸을 채움
    return emptyCellsForWeekDay + modifiedWidgetList;
  }

  UserStateInMail checkUserStateInMail(
      MailInDetail mail, bool isActiveCharacter) {
    if (mail.replies!.isNotEmpty) {
      return UserStateInMail.replied;
    }
    if (isActiveCharacter) {
      if (mail.replies!.isEmpty && mail.is_latest) {
        return UserStateInMail.canReply;
      } else {
        return UserStateInMail.cannotReplyCurrentMonth;
      }
    } else {
      return UserStateInMail.cannotReplyPastMonth;
    }
  }

  List<MailInList> validateAndFilterMails(List<MailInList> mailList) {
    final groupedByDay = <int, List<MailInList>>{};

    for (final mail in mailList) {
      int day = mail.day;
      if (!groupedByDay.containsKey(day)) {
        groupedByDay[day] = [];
      }
      groupedByDay[day]!.add(mail);
    }

    List<MailInList> filteredList = [];
    for (final group in groupedByDay.values) {
      final smallestIdItem = group
          .reduce((current, next) => current.id < next.id ? current : next);
      filteredList.add(smallestIdItem);
    }

    return filteredList;
  }

  Future<void> requestRandomlyAppReview() async {
    final numOfReplies =
        await fetchNumOfRepliesQuery().result.then((value) => value.data);
    if (numOfReplies == null || numOfReplies <= 1) {
      return;
    }
    if (Random().nextInt(100) <= 50) {
      notificationService.requestAppReview();
    }
  }
}
