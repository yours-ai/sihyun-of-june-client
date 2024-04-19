import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_sns.freezed.dart';

part 'character_sns.g.dart';

@freezed
class CharacterSns with _$CharacterSns {
  factory CharacterSns({
    required String platform,
    required String link,
  }) = _CharacterSns;

  factory CharacterSns.fromJson(Map<String, dynamic> json) =>
      _$CharacterSnsFromJson(json);
}
