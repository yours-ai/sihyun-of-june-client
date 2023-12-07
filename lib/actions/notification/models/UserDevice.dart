import 'package:json_annotation/json_annotation.dart';

part 'UserDevice.g.dart';

@JsonSerializable()
class UserDevice {
  int pk;
  int user;
  String device_token;

  UserDevice(
      {required this.pk, required this.user, required this.device_token});

  factory UserDevice.fromJson(Map<String, dynamic> json) =>
      _$UserDeviceFromJson(json);

  Map<String, dynamic> toJson() => _$UserDeviceToJson(this);
}
