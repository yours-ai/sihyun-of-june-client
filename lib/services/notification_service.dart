import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/notification/actions.dart';
import 'package:project_june_client/actions/notification/models/AppNotification.dart';

class NotificationService {
  const NotificationService();

  void handleClickNotification(
      BuildContext context, AppNotification notification) {
    context.go(notification.link ?? '/mails');
    final mutation = Mutation(
      queryFn: (int id) => readNotification(id),
      refetchQueries: ["list-app-notifications"],
    );
    mutation.mutate(notification.id);
  }
}
