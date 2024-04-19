import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification.freezed.dart';

part 'app_notification.g.dart';

@freezed
class AppNotification with _$AppNotification {
  factory AppNotification({
    required int id,
    required DateTime created,
    required DateTime modified,
    required String title,
    required String body,
    String? link,
    bool? is_read,
    required bool is_all,
    required int user,
    Map<String, dynamic>? payload,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
}
