import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_device.freezed.dart';

part 'user_device.g.dart';

@freezed
class UserDevice with _$UserDevice {
  factory UserDevice({
    required int pk,
    required int user,
    required String device_token,
  }) = _UserDevice;

  factory UserDevice.fromJson(Map<String, dynamic> json) =>
      _$UserDeviceFromJson(json);
}
