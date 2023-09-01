import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/actions.dart';

import '../widgets/common/title_layout.dart';

class AllScreen extends StatelessWidget {
  const AllScreen({super.key});

  @override
  Widget build(context) {
    return SafeArea(
      child: TitleLayout(
        titleText: '전체',
        body: Column(
          children: [
            ListTile(
              title: Text('로그아웃'),
              onTap: () {
                logout();
                context.go('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
