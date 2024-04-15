import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';
import 'package:project_june_client/widgets/notification/notification_widget.dart';

import '../actions/notification/queries.dart';

class NotificationListScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic>? fcmData;

  const NotificationListScreen(this.fcmData, {super.key});

  @override
  NotificationListScreenState createState() => NotificationListScreenState();
}

class NotificationListScreenState extends ConsumerState<NotificationListScreen>
    with SingleTickerProviderStateMixin {
  bool isAllRead = true;
  AnimationController? reloadNotificationController;
  Animation<double>? reloadNotificationFadeAnimation;

  @override
  void initState() {
    super.initState();
    reloadNotificationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // 애니메이션 지속 시간
    );
    reloadNotificationFadeAnimation = Tween<double>(begin: 1.0, end: 0.0)
        .animate(reloadNotificationController!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.fcmData != null && widget.fcmData?['link'] != null) {
        final Map<String, String> payload =
            notificationService.getPayloadInFcmData(widget.fcmData ?? {});
        final redirectLink = widget.fcmData?['link'];
        notificationService.routeRedirectLink(
          redirectLink: redirectLink,
          context: context,
          characterColors: ref.read(selectedCharacterProvider)?.theme.colors ??
              ProjectConstants.defaultTheme.colors,
          payload: payload,
        );
      }
    });
  }

  @override
  Widget build(context) {
    final notificationQuery = fetchNotificationListQuery();
    return Scaffold(
      body: QueryBuilder(
        query: notificationQuery,
        builder: (context, state) {
          if (state.data == null) {
            return const SizedBox.shrink();
          }
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              if (state.data!.isNotEmpty) {
                setState(() {
                  isAllRead = state.data!
                      .every((notification) => notification.is_read!);
                });
              }
            },
          );
          return SafeArea(
            child: TitleLayout(
              title: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => context.pop(),
                          icon: Icon(
                            PhosphorIcons.arrow_left,
                            color: ColorConstants.primary,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const TitleUnderline(
                    titleText: '알림',
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MutationBuilder(
                          mutation: readAllNotificationMutation(
                            refetchQueries: ['list-app-notifications'],
                            onError: (arg, error, fallback) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(error.toString()),
                                ),
                              );
                            },
                          ),
                          builder: (context, state, mutate) => TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              minimumSize: Size.zero,
                              backgroundColor: isAllRead
                                  ? const Color(0xffF4F4F4)
                                  : const Color(0xffEEEEEE),
                            ),
                            onPressed: () {
                              if (isAllRead) {
                                return;
                              }
                              mutate(null);
                            },
                            child: Text(
                              '모두 읽음',
                              style: TextStyle(
                                color: isAllRead
                                    ? const Color(0xffBABABA)
                                    : ColorConstants.primary,
                                fontSize: 12,
                                fontWeight: FontWeightConstants.semiBold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              body: state.data!.isEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            '아직 도착한 알림이 없습니다.',
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorConstants.neutral,
                              fontWeight: FontWeightConstants.semiBold,
                            ),
                          ),
                        ),
                      ],
                    )
                  : RefreshIndicator.adaptive(
                      onRefresh: () async {
                        HapticFeedback.lightImpact();
                        reloadNotificationController!.forward().then((_) async {
                          await notificationQuery.refetch();
                          reloadNotificationController!.reverse();
                        });
                      },
                      child: FadeTransition(
                        opacity: reloadNotificationFadeAnimation!,
                        child: ListView(
                          children: state.data!
                              .map<Widget>(
                                (notification) => NotificationWidget(
                                  notification: notification,
                                  characterColors: ref
                                          .watch(selectedCharacterProvider)
                                          ?.theme
                                          .colors ??
                                      ProjectConstants.defaultTheme.colors,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
