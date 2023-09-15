import 'package:json_annotation/json_annotation.dart';

part 'AppNotification.g.dart';

@JsonSerializable()
class AppNotification {
  int id;
  DateTime created;
  DateTime modified;
  String title;
  String body;
  String? link;
  bool? is_read;
  bool is_all;
  num user;

  AppNotification({
    required this.id,
    required this.created,
    required this.modified,
    required this.title,
    required this.body,
    this.link,
    this.is_read,
    required this.is_all,
    required this.user,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$AppNotificationToJson(this);
}
