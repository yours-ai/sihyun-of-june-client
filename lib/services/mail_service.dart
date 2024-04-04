import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/mails/models/MailInDetail.dart';
import 'package:project_june_client/actions/mails/models/MailInList.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/contrib/flutter_secure_storage.dart';
import 'package:project_june_client/screens/mail/mail_detail_screen.dart';
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

  String getNextMailReceiveTimeStr() {
    TimeOfDay now = TimeOfDay.fromDateTime(clock.now());
    if (now.compareTo(ProjectConstants.mailReceiveTime) >= 0) {
      return '내일 저녁 9시';
    }
    return '오늘 저녁 9시';
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
    final beforeReply = await storage.read(key: 'MAIL_REPLY_$mailId');
    if (beforeReply != null) {
      controller.text = beforeReply;
    }
  }

  Future<void> saveBeforeReply({
    required String reply,
    required int mailId,
  }) async {
    final storage = getSecureStorage();
    await storage.write(key: 'MAIL_REPLY_$mailId', value: reply);
  }

  Future<void> deleteBeforeReply(int mailId) async {
    final storage = getSecureStorage();
    await storage.delete(key: 'MAIL_REPLY_$mailId');
  }

  int checkMailNumber(List<MailInList> mails, DateTime firstMailDate) {
    final lastMailDate = mails.first.available_at;
    final totalMailNumber = getMailDateDiff(lastMailDate, firstMailDate) + 1;
    return totalMailNumber;
  }

  List<Widget> makeMailWidgetList(List<MailInList> mails) {
    if (mails.isEmpty) {
      return [];
    }
    final firstMailDate = mails.last.available_at;
    final mailCount = checkMailNumber(mails, firstMailDate);
    List<MailWidget> modifiedMailList = [];
    if (mailCount <= 30) {
      modifiedMailList = List.generate(
          30,
          (index) => MailWidget(
                mailNumber: index,
                firstMailDate: firstMailDate,
              ));
    } else {
      modifiedMailList = List.generate(
          mailCount,
          (index) => MailWidget(
                mailNumber: index,
                firstMailDate: firstMailDate,
              ));
    }
    for (var mail in mails) {
      int mailDateDiff = getMailDateDiff(mail.available_at, firstMailDate);
      modifiedMailList[mailDateDiff] = MailWidget(
        mail: mail,
        mailNumber: mailDateDiff,
        firstMailDate: firstMailDate,
      );
    }
    return fillMailList(modifiedMailList, firstMailDate);
  }

  List<Widget> fillMailList(
      List<Widget> modifiedWidgetList, DateTime firstMailDate) {
    List<Widget> emptyCellsForWeekDay =
        getEmptyCells(firstMailDate); //첫 번째 날짜의 요일에 따라 빈 칸을 채움
    return emptyCellsForWeekDay + modifiedWidgetList;
  }

  UserStateInMail checkUserStateInMail(MailInDetail mail, Character character) {
    if (mail.replies!.isNotEmpty) {
      return UserStateInMail.replied;
    }
    final recentAssignedAt = character.assigned_characters!.last.first_mail_available_at;
    final isRecentCharacterMail = mail.available_at.isAfter(
      recentAssignedAt,
    );
    if (isRecentCharacterMail) {
      if (mail.replies!.isEmpty && mail.is_latest) {
        return UserStateInMail.canReply;
      } else {
        return UserStateInMail.cannotReplyCurrentMonth;
      }
    } else {
      return UserStateInMail.cannotReplyPastMonth;
    }
  }
}
