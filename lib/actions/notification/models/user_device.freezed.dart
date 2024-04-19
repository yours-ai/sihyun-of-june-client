// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserDevice _$UserDeviceFromJson(Map<String, dynamic> json) {
  return _UserDevice.fromJson(json);
}

/// @nodoc
mixin _$UserDevice {
  int get pk => throw _privateConstructorUsedError;
  int get user => throw _privateConstructorUsedError;
  String get device_token => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserDeviceCopyWith<UserDevice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDeviceCopyWith<$Res> {
  factory $UserDeviceCopyWith(
          UserDevice value, $Res Function(UserDevice) then) =
      _$UserDeviceCopyWithImpl<$Res, UserDevice>;
  @useResult
  $Res call({int pk, int user, String device_token});
}

/// @nodoc
class _$UserDeviceCopyWithImpl<$Res, $Val extends UserDevice>
    implements $UserDeviceCopyWith<$Res> {
  _$UserDeviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pk = null,
    Object? user = null,
    Object? device_token = null,
  }) {
    return _then(_value.copyWith(
      pk: null == pk
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as int,
      device_token: null == device_token
          ? _value.device_token
          : device_token // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserDeviceImplCopyWith<$Res>
    implements $UserDeviceCopyWith<$Res> {
  factory _$$UserDeviceImplCopyWith(
          _$UserDeviceImpl value, $Res Function(_$UserDeviceImpl) then) =
      __$$UserDeviceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int pk, int user, String device_token});
}

/// @nodoc
class __$$UserDeviceImplCopyWithImpl<$Res>
    extends _$UserDeviceCopyWithImpl<$Res, _$UserDeviceImpl>
    implements _$$UserDeviceImplCopyWith<$Res> {
  __$$UserDeviceImplCopyWithImpl(
      _$UserDeviceImpl _value, $Res Function(_$UserDeviceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pk = null,
    Object? user = null,
    Object? device_token = null,
  }) {
    return _then(_$UserDeviceImpl(
      pk: null == pk
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as int,
      device_token: null == device_token
          ? _value.device_token
          : device_token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserDeviceImpl implements _UserDevice {
  _$UserDeviceImpl(
      {required this.pk, required this.user, required this.device_token});

  factory _$UserDeviceImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserDeviceImplFromJson(json);

  @override
  final int pk;
  @override
  final int user;
  @override
  final String device_token;

  @override
  String toString() {
    return 'UserDevice(pk: $pk, user: $user, device_token: $device_token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDeviceImpl &&
            (identical(other.pk, pk) || other.pk == pk) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.device_token, device_token) ||
                other.device_token == device_token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, pk, user, device_token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDeviceImplCopyWith<_$UserDeviceImpl> get copyWith =>
      __$$UserDeviceImplCopyWithImpl<_$UserDeviceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserDeviceImplToJson(
      this,
    );
  }
}

abstract class _UserDevice implements UserDevice {
  factory _UserDevice(
      {required final int pk,
      required final int user,
      required final String device_token}) = _$UserDeviceImpl;

  factory _UserDevice.fromJson(Map<String, dynamic> json) =
      _$UserDeviceImpl.fromJson;

  @override
  int get pk;
  @override
  int get user;
  @override
  String get device_token;
  @override
  @JsonKey(ignore: true)
  _$$UserDeviceImplCopyWith<_$UserDeviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
