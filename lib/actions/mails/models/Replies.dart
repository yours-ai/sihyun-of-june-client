import 'package:json_annotation/json_annotation.dart';

part 'Replies.g.dart';


@JsonSerializable()
class RepliesBean {
  num id;
  String description;
  int created;
  int modified;

  RepliesBean({required this.id, required this.description,required this.created,required this.modified});

  factory RepliesBean.fromJson(Map<String, dynamic> json) => _$RepliesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$RepliesBeanToJson(this);
}