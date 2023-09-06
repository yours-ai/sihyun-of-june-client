import 'package:cached_query_flutter/cached_query_flutter.dart';

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
