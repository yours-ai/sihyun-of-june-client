import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/constants.dart';

final tabList = [
  RoutePaths.home,
  RoutePaths.between,
  RoutePaths.mailList,
  RoutePaths.all,
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
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          HapticFeedback.lightImpact();
          context.go(tabList[index]);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              PhosphorIcons.house_simple,
              size: 32,
              color: ColorConstants.gray,
            ),
            activeIcon: Icon(
              //TODO: 체크 스택으로 만들기
              PhosphorIcons.house_simple,
              size: 32,
              color: ColorConstants.gray,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              PhosphorIcons.list_bullets,
              size: 32,
              color: ColorConstants.gray,
            ),
            activeIcon: Icon(
              //TODO: 체크 스택으로 만들기
              PhosphorIcons.list_bullets,
              size: 32,
              color: ColorConstants.gray,
            ),
            label: '서로에 대해',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              PhosphorIcons.calendar,
              size: 32,
              color: ColorConstants.gray,
            ),
            activeIcon: Icon(
              //TODO: 체크 스택으로 만들기
              PhosphorIcons.calendar,
              size: 32,
              color: ColorConstants.gray,
            ),
            label: '받은 편지함',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              PhosphorIcons.gear,
              size: 32,
              color: ColorConstants.gray,
            ),
            activeIcon: Icon(
              //TODO: 체크 스택으로 만들기
              PhosphorIcons.gear,
              size: 32,
              color: ColorConstants.gray,
            ),
            label: '설정',
          ),
        ],
      ),
    );
  }
}
