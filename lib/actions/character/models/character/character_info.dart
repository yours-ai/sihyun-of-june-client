import 'package:project_june_client/actions/character/models/character/character_cinematic.dart';
import 'package:project_june_client/actions/character/models/character/character_image.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:project_june_client/actions/character/models/character/character_sns.dart';

part 'character_info.freezed.dart';

part 'character_info.g.dart';

@freezed
class CharacterInfo with _$CharacterInfo {
  factory CharacterInfo({
    required num age,
    required String one_line_description,
    required String summary_description,
    required CharacterCinematic cinematic,
    required String description,
    required List<CharacterImage> images,
    List<CharacterSns>? sns,
  }) = _CharacterInfo;

  factory CharacterInfo.fromJson(Map<String, dynamic> json) =>
      _$CharacterInfoFromJson(json);
}
