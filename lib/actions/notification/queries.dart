import 'package:cached_query_flutter/cached_query_flutter.dart';

import 'actions.dart';
import 'models/app_notification.dart';

Query<bool> fetchIsNotificationAcceptedQuery({OnQueryErrorCallback? onError}) {
  return Query<bool>(
    key: 'notification-accepted',
    queryFn: () => fetchIsNotificationAccepted(),
    onError: onError,
  );
}

Mutation<void, void> requestNotificationPermissionMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, void>(
    queryFn: (void _) => requestNotificationPermission(),
    onSuccess: onSuccess,
    onError: onError,
  );
}

Query<List<AppNotification>> fetchNotificationListQuery({
  OnQueryErrorCallback? onError,
}) {
  return Query<List<AppNotification>>(
    key: 'list-app-notifications',
    queryFn: () => fetchNotificationList(),
    onError: onError,
  );
}

Mutation<void, int> readNotificationMutation({
  List<String> refetchQueries = const [],
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, int>(
    refetchQueries: refetchQueries,
    queryFn: readNotification,
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<void, void> readAllNotificationMutation({
  List<String> refetchQueries = const [],
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, void>(
    refetchQueries: refetchQueries,
    queryFn: (void _) => readAllNotification(),
    onSuccess: onSuccess,
    onError: onError,
  );
}

