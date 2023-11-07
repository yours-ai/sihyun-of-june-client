import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/notification/queries.dart';
import 'package:project_june_client/constants.dart';

import 'navbar/navbar_icon.dart';
import 'navbar/notification_icon.dart';

final tabList = [
  TabRoutePaths.mailList,
  TabRoutePaths.notificationList,
  TabRoutePaths.all,
];

class NavbarLayout extends StatelessWidget {
  final Widget child;
  final String? routePath;

  const NavbarLayout({Key? key, required this.child, required this.routePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final query = getListAppNotificationQuery();
    return Scaffold(
      body: child,
      bottomNavigationBar: QueryBuilder(
          query: query,
          builder: (context, state) {
            final hasUnread = state.data
                    ?.where((notification) => notification.is_read != true)
                    .isNotEmpty ??
                false;
            return BottomNavigationBar(
              currentIndex: routePath != null ? tabList.indexOf(routePath!) : 0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (index) {
                context.go(tabList[index]);
              },
              selectedItemColor: ColorConstants.primary,
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Image.asset('assets/images/navbar/mail.png',
                        height: 32),
                  ),
                  activeIcon: const NavbarIconWidget(
                    IMGpath: 'assets/images/navbar/mail_active.png',
                    RotateDirection: 'left',
                  ),
                  label: '받은 편지함',
                ),
                BottomNavigationBarItem(
                  icon: NotificationIconWidget(
                    hasUnread: hasUnread,
                  ),
                  activeIcon: const NavbarIconWidget(
                      IMGpath: 'assets/images/navbar/bell_active.png',
                      RotateDirection: 'left'),
                  label: '알림',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Image.asset('assets/images/navbar/menu.png',
                        height: 32),
                  ),
                  activeIcon: const NavbarIconWidget(
                      IMGpath: 'assets/images/navbar/menu_active.png',
                      RotateDirection: 'right'),
                  label: '전체',
                ),
              ],
            );
          }),
    );
  }
}
