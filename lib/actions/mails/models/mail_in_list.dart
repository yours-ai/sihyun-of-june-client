import 'package:project_june_client/actions/mails/models/reply.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'mail_in_list.freezed.dart';

part 'mail_in_list.g.dart';

mixin MailMixin {
  int get id;
  int get assign;
  DateTime get available_at;
  List<Reply>? get replies;
  int get day;
  bool get has_permission;
  bool get is_read;
}

@freezed
class MailInList with _$MailInList, MailMixin {
  factory MailInList({
    required int id,
    required int assign,
    required DateTime available_at,
    List<Reply>? replies,
    required int day,
    required bool has_permission,
    required bool is_read,
  }) = _MailInList;

  factory MailInList.fromJson(Map<String, dynamic> json) =>
      _$MailInListFromJson(json);
}
