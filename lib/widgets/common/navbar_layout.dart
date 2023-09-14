import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/router.dart';

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
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: routePath != null ? tabList.indexOf(routePath!) : 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          context.go(tabList[index]);
        },
        selectedItemColor: ColorConstants.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              PhosphorIcons.envelope_simple_light,
              size: 32,
            ),
            activeIcon: Icon(
              PhosphorIcons.envelope_simple_fill,
              size: 32,
            ),
            label: '받은 편지함',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              PhosphorIcons.bell_light,
              size: 32,
            ),
            activeIcon: Icon(
              PhosphorIcons.bell_fill,
              size: 32,
            ),
            label: '알림',
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.list_light, size: 32),
            activeIcon: Icon(
              PhosphorIcons.list_bold,
              size: 32,
            ),
            label: '전체',
          ),
        ],
      ),
    );
  }
}
