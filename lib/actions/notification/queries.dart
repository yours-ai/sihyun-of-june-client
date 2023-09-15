import 'package:cached_query_flutter/cached_query_flutter.dart';

import 'actions.dart';
import 'models/AppNotification.dart';

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

Query<List<AppNotification>> getListAppNotificationQuery({
  OnQueryErrorCallback? onError,
}) {
  return Query<List<AppNotification>>(
    key: 'list-app-notifications',
    queryFn: () => listAppNotifications(),
    onError: onError,
  );
}
