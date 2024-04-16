import 'package:json_annotation/json_annotation.dart';
import 'package:project_june_client/actions/mails/models/Reply.dart';

import 'MailInList.dart';

part 'MailInDetail.g.dart';

@JsonSerializable()
class MailInDetail extends MailInList {
  int to;
  String to_first_name;
  String? to_image;
  int by;
  String description;
  bool is_latest;

  MailInDetail({
    required this.to,
    required this.to_first_name,
    this.to_image,
    required this.by,
    required this.description,
    required this.is_latest,
    required super.id,
    required super.assign,
    required super.available_at,
    required super.replies,
    required super.day,
    required super.has_permission,
    required super.is_read,
  });

  factory MailInDetail.fromJson(Map<String, dynamic> json) =>
      _$MailInDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MailInDetailToJson(this);
}
