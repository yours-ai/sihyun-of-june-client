import 'package:json_annotation/json_annotation.dart';

part 'Reply.g.dart';

@JsonSerializable()
class Reply {
  num id;
  String description;
  String created;
  String modified;

  Reply(
      {required this.id,
      required this.description,
      required this.created,
      required this.modified});

  factory Reply.fromJson(Map<String, dynamic> json) =>
      _$ReplyFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyToJson(this);
}
