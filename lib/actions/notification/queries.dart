import 'package:cached_query_flutter/cached_query_flutter.dart';

import 'actions.dart';

Query<bool> getIsNotificationAcceptedQuery() {
  return Query<bool>(
    key: ['notification-accepted'],
    queryFn: () => getIsNotificationAccepted(),
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
