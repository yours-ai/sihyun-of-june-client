import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_june_client/constants.dart';

import '../actions/mails/models/Mail.dart';

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

  bool isMailReplyable(Mail mail) {
    DateTime dueDate = mail.available_at.add(Duration(days: 1));
    DateTime dueDateTime = DateTime(dueDate.year, dueDate.month, dueDate.day,
        ProjectConstants.mailSendDueTime.hour, ProjectConstants.mailSendDueTime.minute);
    return clock.now().isBefore(dueDateTime);
  }

  String formatMailDate(DateTime dt) {
    return DateFormat('yyyy.MM.dd').format(dt);
  }
}
