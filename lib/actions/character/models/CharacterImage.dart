import 'package:json_annotation/json_annotation.dart';

part 'CharacterImage.g.dart';

@JsonSerializable()
class CharacterImage {
  num? order;
  String? src, quest_text;
  bool? is_blurred, is_main;

  CharacterImage({
    this.order,
    this.src,
    this.quest_text,
    this.is_blurred,
    this.is_main,
  });

  factory CharacterImage.fromJson(Map<String, dynamic> json) =>
      _$CharacterImageFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterImageToJson(this);
}
