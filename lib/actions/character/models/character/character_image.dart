import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_image.freezed.dart';

part 'character_image.g.dart';

@freezed
class CharacterImage with _$CharacterImage {
  factory CharacterImage({
    required int order,
    required String src,
    required String quest_text,
    required bool is_blurred,
    required bool is_main,
  }) = _CharacterImage;

  factory CharacterImage.fromJson(Map<String, dynamic> json) =>
      _$CharacterImageFromJson(json);
}
