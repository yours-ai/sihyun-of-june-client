import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_june_client/constants.dart';

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
      return "내일 저녁 9시";
    }
    return "오늘 저녁 9시";
  }

  int getMailDateDiff(DateTime dt, DateTime firstMailDate) {
    DateTime normalizedDt = DateTime(dt.year, dt.month, dt.day);
    DateTime normalizedFirstMailDate =
        DateTime(firstMailDate.year, firstMailDate.month, firstMailDate.day);
    return normalizedDt.difference(normalizedFirstMailDate).inDays;
  }

  String getMailReceiveDateStr(DateTime dt, bool needMonth) {
    if (needMonth || dt.day == 1) {
      return DateFormat('M월 d일').format(dt);
    }
    return DateFormat('d').format(dt);
  }

  String formatMailDate(DateTime dt) {
    return DateFormat('yyyy.MM.dd').format(dt);
  }
}
