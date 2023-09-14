import 'package:cached_query_flutter/cached_query_flutter.dart';

import 'actions.dart';

Query<bool> getIsNotificationAcceptedQuery({OnQueryErrorCallback? onError}) {
  return Query<bool>(
    key: 'notification-accepted',
    queryFn: () => getIsNotificationAccepted(),
    onError: onError,
  );
}

Mutation<void, void> getRequestNotificationPermissionMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, void>(
    queryFn: (void _) => requestNotificationPermission(),
    onSuccess: onSuccess,
    onError: onError,
  );
}
