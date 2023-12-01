import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';
import 'package:project_june_client/widgets/notification_widget.dart';

import '../actions/notification/queries.dart';

class NotificationListScreen extends StatefulWidget {
  final String? redirectLink;

  const NotificationListScreen(this.redirectLink, {super.key});

  @override
  State<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.redirectLink != null) {
        notificationService.routeRedirectLink(widget.redirectLink);
      }
    });
  }

  @override
  Widget build(context) {
    final query = getListAppNotificationQuery();
    return QueryBuilder(
        query: query,
        builder: (context, state) {
          if (state.data == null) {
            return const SizedBox.shrink();
          }
          return SafeArea(
            child: TitleLayout(
              title: const Center(
                child: TitleUnderline(
                  titleText: "알림",
                ),
              ),
              body: state.data!.isEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            "아직 도착한 알림이 없습니다.",
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorConstants.neutral,
                              fontWeight: FontWeightConstants.semiBold,
                            ),
                          ),
                        ),
                      ],
                    )
                  : ListView(
                      children: state.data!
                          .map<Widget>(
                            (notification) => NotificationWidget(
                              notification: notification,
                            ),
                          )
                          .toList(),
                    ),
            ),
          );
        });
  }
}
