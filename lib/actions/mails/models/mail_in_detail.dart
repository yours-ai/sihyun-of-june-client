import 'package:project_june_client/actions/mails/models/reply.dart';

import 'mail_in_list.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'mail_in_detail.freezed.dart';

part 'mail_in_detail.g.dart';

@freezed
class MailInDetail with _$MailInDetail, MailMixin {
  factory MailInDetail({
    required int id,
    required int assign,
    required DateTime available_at,
    List<Reply>? replies,
    required int day,
    required bool has_permission,
    required bool is_read,
    required int to,
    required String to_first_name,
    String? to_image,
    required int by,
    required String description,
    required bool is_latest,
  }) = _MailInDetail;

  factory MailInDetail.fromJson(Map<String, dynamic> json) =>
      _$MailInDetailFromJson(json);
}
