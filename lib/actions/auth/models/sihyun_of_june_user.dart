import 'package:freezed_annotation/freezed_annotation.dart';

part 'sihyun_of_june_user.freezed.dart';

part 'sihyun_of_june_user.g.dart';

@freezed
class SihyunOfJuneUser with _$SihyunOfJuneUser {
  factory SihyunOfJuneUser({
    required int id,
    String? phone,
    required String last_name,
    required String first_name,
    required bool is_active,
    required bool is_activable,
    required int coin,
    required int point,
    required String env,
    String? image,
    required bool is_30days_finished,
  }) = _SihyunOfJuneUser;

  factory SihyunOfJuneUser.fromJson(Map<String, dynamic> json) =>
      _$SihyunOfJuneUserFromJson(json);
}
