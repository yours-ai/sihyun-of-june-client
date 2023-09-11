import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:project_june_client/actions/auth/dtos.dart';

import 'actions.dart';

Mutation<void, void> getLoginAsKakaoMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, void>(
    queryFn: (void _) async {
      final token = await getKakaoOAuthToken();
      final serverToken = await getServerTokenByKakaoToken(token);
      await saveServerToken(serverToken);
    },
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<void, void> getLoginAsAppleMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, void>(
    queryFn: (void _) async {
      final appleCredentials = await getAppleLoginCredential();
      final serverToken = await getServerTokenByAppleCredential(appleCredentials);
      await saveServerToken(serverToken);
    },
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<void, String> getSmsSendMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, String>(
    queryFn: smsSend,
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<bool, ValidatedAuthCodeDTO> getSmsVerifyMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<bool, ValidatedAuthCodeDTO>(
    queryFn: smsVerify,
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<void, ValidatedUserDTO> getSmsTokenMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, ValidatedUserDTO>(
    queryFn: (validatedUserDTO) async{
      final serverToken = await getServerTokenBySMS(validatedUserDTO);
      await saveServerToken(serverToken);
    },
    onSuccess: onSuccess,
    onError: onError,
  );
}

