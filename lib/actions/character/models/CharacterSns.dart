import 'package:json_annotation/json_annotation.dart';

part 'CharacterSns.g.dart';

@JsonSerializable()
class CharacterSns {
  String platform;
  String link;

  CharacterSns({required this.platform,required this.link});

  factory CharacterSns.fromJson(Map<String, dynamic> json) =>
      _$CharacterSnsFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterSnsToJson(this);
}
