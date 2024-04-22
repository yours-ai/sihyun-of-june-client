import 'package:dio/dio.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:project_june_client/actions/auth/dtos.dart';
import 'package:project_june_client/actions/auth/models/token.dart';
import 'package:project_june_client/actions/client.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/contrib/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'actions_new.g.dart';

void setServerTokenOnDio(String serverToken) {
  dio.options.headers['Authorization'] = 'Token $serverToken';
}

Future<void> _login(String serverToken, {bool? saveTokenToClient}) async {
  saveTokenToClient ??= true;
  setServerTokenOnDio(serverToken);
  if (saveTokenToClient) {
    final storage = getSecureStorage();
    await storage.write(
        key: StorageKeyConstants.serverToken, value: serverToken);
  }
}

@riverpod
class AppleLogin extends _$AppleLogin {
  @override
  FutureOr<AuthorizationCredentialAppleID> build() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
      );
      return credential;
    } catch (error) {
      rethrow;
    }
  }

  Future<String> _getServerToken(
      AuthorizationCredentialAppleID appleCredentials) async {
    Map<String, dynamic> data = {
      'user_id': appleCredentials.userIdentifier,
    };

    if (appleCredentials.email != null) {
      data['user'] = {
        'email': appleCredentials.email,
        'name': {
          'firstName': appleCredentials.givenName,
          'lastName': appleCredentials.familyName
        }
      };
    }

    final response = await dio
        .post('/auth/apple/join-or-login/by-id/', data: data)
        .then<Token>((response) => Token.fromJson(response.data));
    return response.token;
  }

  void login() async {
    final appleCredentials = await build();
    final serverToken = await _getServerToken(appleCredentials);
    await _login(serverToken);
  }
}

@riverpod
Future<void> sendSmsVerification(SendSmsVerificationRef ref, String phoneNumber) async {
  await dio.post('/auth/sms-auth/send/',
      data: {'phone': phoneNumber, 'country_code': '82'});
}

@riverpod
Future<bool> verifySmsCode(VerifySmsCodeRef ref,ValidatedAuthCodeDTO dto) async {
  try {
    final response = await dio.post('/auth/sms-auth/verify/', data: {
      'phone': dto.phone,
      'country_code': dto.countryCode,
      'auth_code': dto.authCode,
    });
    return await response.data['is_joined'];
  } catch (error) {
    if (error is DioException) {
      if (error.response != null && error.response!.data != null) {
        String detailError = error.response!.data['detail'].toString();
        throw detailError;
      }
    }
    rethrow;
  }
}

@riverpod
Future<String> serverTokenBySMS(ServerTokenBySMSRef ref, ValidatedUserDTO dto) async {
  try {
    final response = await dio.post('/auth/sms-auth/join-or-login/', data: {
      'phone': dto.phone,
      'country_code': dto.countryCode,
      'auth_code': dto.authCode,
      'last_name': dto.lastName,
      'first_name': dto.firstName
    }).then<Token>((response) => Token.fromJson(response.data));
    return response.token;
  } catch (error) {
    if (error is DioException) {
      if (error.response != null && error.response!.data != null) {
        String detailError = error.response!.data['detail'];
        throw detailError;
      }
    }
    rethrow;
  }
}

@riverpod
Future<String> serverTokenBySMSLogin(ServerTokenBySMSLoginRef ref,ValidatedAuthCodeDTO dto) async {
  try {
    final response = await dio.post('/auth/sms-auth/join-or-login/', data: {
      'phone': dto.phone,
      'country_code': dto.countryCode,
      'auth_code': dto.authCode,
    }).then<Token>((response) => Token.fromJson(response.data));
    return response.token;
  } catch (error) {
    if (error is DioException) {
      if (error.response != null && error.response!.data != null) {
        String detailError = error.response!.data['detail'];
        throw detailError;
      }
    }
    rethrow;
  }
}

@riverpod
class KakaoLogin extends _$KakaoLogin {
  @override
  FutureOr<OAuthToken> build() async {
    if (await isKakaoTalkInstalled()) {
      try {
        return await UserApi.instance.loginWithKakaoTalk();
      } catch (error) {
        if (error is PlatformException && error.code == 'CANCELED') {
          rethrow;
        }
        return await UserApi.instance.loginWithKakaoAccount();
      }
    }
    return await UserApi.instance.loginWithKakaoAccount();
  }

  FutureOr<String> _getServerToken(OAuthToken token) async {
    final tokenInstance =
    await dio.post('/auth/kakao/join-or-login/by-token/', data: {
      'token': token.accessToken,
    }).then<Token>((response) => Token.fromJson(response.data));
    return tokenInstance.token;
  }
}