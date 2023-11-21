import 'package:cached_query_flutter/cached_query_flutter.dart';

import 'actions.dart';

Mutation<void, String?> getUserFunnelMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, String?>(
    queryFn: sendUserFunnel,
    onSuccess: onSuccess,
    onError: onError,
  );
}
