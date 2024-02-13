import 'dart:typed_data';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:project_june_client/actions/auth/dtos.dart';

import 'actions.dart';
import 'models/SihyunOfJuneUser.dart';

Mutation<void, void> loginAsKakaoMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, void>(
    queryFn: (void _) async {
      final token = await fetchKakaoOAuthToken();
      final serverToken = await fetchServerTokenByKakaoToken(token);
      await login(serverToken);
    },
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<void, void> loginAsAppleMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, void>(
    queryFn: (void _) async {
      final appleCredentials = await fetchAppleLoginCredential();
      final serverToken =
          await fetchServerTokenByAppleCredential(appleCredentials);
      await login(serverToken);
    },
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<void, String> sendSmsVerificationMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, String>(
    queryFn: sendSmsVerification,
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<bool, ValidatedAuthCodeDTO> verifySmsCodeMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<bool, ValidatedAuthCodeDTO>(
    queryFn: verifySmsCode,
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<void, ValidatedVerifyDTO> fetchSmsTokenMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, ValidatedVerifyDTO>(
    queryFn: (dto) async {
      if (dto is ValidatedUserDTO) {
        final serverToken = await fetchServerTokenBySMS(dto);
        await login(serverToken);
      } else if (dto is ValidatedAuthCodeDTO) {
        final serverToken = await fetchServerTokenBySMSLogin(dto);
        await login(serverToken);
      }
    },
    onSuccess: onSuccess,
    onError: onError,
  );
}

Query<SihyunOfJuneUser> fetchMeQuery({
  OnQuerySuccessCallback<SihyunOfJuneUser>? onSuccess,
}) {
  return Query<SihyunOfJuneUser>(
    queryFn: fetchMe,
    key: 'retrieve-me',
    onSuccess: onSuccess,
  );
}

Mutation<void, UserNameDTO> changeNameMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, UserNameDTO>(
    refetchQueries: ['retrieve-me'],
    queryFn: changeName,
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<void, QuitReasonDTO> withdrawUserMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, QuitReasonDTO>(
    queryFn: withdrawUser,
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<void, Uint8List> uploadUserImageMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, Uint8List>(
    refetchQueries: ['retrieve-me'],
    queryFn: uploadUserImage,
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<void, void> deleteUserImageMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, void>(
    refetchQueries: ['retrieve-me'],
    queryFn: (void _) async {
      await deleteUserImage();
    },
    onSuccess: onSuccess,
    onError: onError,
  );
}

Query<String> fetchReferralCodeQuery({
  OnQuerySuccessCallback<String>? onSuccess,
}) {
  return Query(
    queryFn: fetchReferralCode,
    key: 'refferal-code',
    onSuccess: onSuccess,
  );
}
