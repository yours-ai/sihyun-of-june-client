import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:project_june_client/actions/client.dart';
import 'package:project_june_client/contrib/flutter_secure_storage.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'models/Token.dart';

const _SERVER_TOKEN_KEY = 'SERVER_TOKEN';

Future<AuthorizationCredentialAppleID> getAppleLoginCredential() async {
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

Future<String> getServerTokenByAppleCredential(
    AuthorizationCredentialAppleID appleCredentials) async {
  Map<String, dynamic> data = {
    "user_id": appleCredentials.userIdentifier,
  };

  if (appleCredentials.email != null) {
    data["user"] = {
      "email": appleCredentials.email,
      "name": {
        "firstName": appleCredentials.givenName,
        "lastName": appleCredentials.familyName
      }
    };
  }

  final response = await dio
      .post('/auth/apple/join-or-login/by-id/', data: data)
      .then<Token>((response) => Token.fromJson(response.data));
  return response.token;
}

Future<String> smsSend(int phoneNumber) async {
  final response = await dio.post('/auth/sms-auth/send/',
      data: {'phone': phoneNumber, 'country_code': '82'});
  return response.data['result'];
}

Future<String> smsVerify(int phoneNumber, int authNumber) async {
  try{
    final response = await dio.post('/auth/sms-auth/verify/', data: {
      'phone': phoneNumber,
      'country_code': '82',
      'auth_code': authNumber
    });
    return response.data['result'];
  }
  catch(error){
    return Future.error(error);
  }
}

Future<String> getServerTokenBySMS(
    int phoneNumber, lastName, firstName) async {
  final response = await dio.post('/auth/sms-auth/join-or-login/', data: {
    'phone': phoneNumber,
    'country_code': '82',
    'last_name': lastName,
    'first_name': firstName
  }).then<Token>((response) => Token.fromJson(response.data));
  saveServerToken(response.token);
  return response.token;
}

Future<OAuthToken> getKakaoOAuthToken() async {
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

Future<String> getServerTokenByKakaoToken(OAuthToken token) async {
  final response = await dio.post('/auth/kakao/join-or-login/by-token/', data: {
    'token': token.accessToken,
  }).then<Token>((response) => Token.fromJson(response.data));
  return response.token;
}

void setServerTokenOnDio(String serverToken) {
  dio.options.headers['Authorization'] = "Token $serverToken";
}

Future<void> saveServerToken(String serverToken) async {
  setServerTokenOnDio(serverToken);
  final storage = getSecureStorage();
  await storage.write(key: _SERVER_TOKEN_KEY, value: serverToken);
  return;
}

Future<String?> getServerToken() async {
  final storage = getSecureStorage();
  return await storage.read(key: _SERVER_TOKEN_KEY);
}

Future<bool> loadServerToken() async {
  final storage = getSecureStorage();
  final loaded = await storage.read(key: _SERVER_TOKEN_KEY);
  if (loaded == null) return false;
  setServerTokenOnDio(loaded);
  return true;
}

logout() async {
  final storage = getSecureStorage();
  await storage.deleteAll();
  try {
    await UserApi.instance.logout();
  } catch (e) {}
  CachedQuery.instance.deleteCache();
  dio.options.headers.clear();
  return;
}
