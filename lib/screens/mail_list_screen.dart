import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/widgets/mail_widget.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/modal_widget.dart';
import 'package:project_june_client/widgets/notification_permission_check.dart';

import '../actions/notification/queries.dart';
import '../constants.dart';

class MailListScreen extends StatefulWidget {
  const MailListScreen({super.key});

  @override
  State<MailListScreen> createState() => _MailListScreenState();
}

class _MailListScreenState extends State<MailListScreen> {
  final int _mailNum = 9;

  @override
  Widget build(context) {
    final query = getIsNotificationAcceptedQuery();
    return SafeArea(
      child: TitleLayout(
        showProfile: Padding(
          padding: const EdgeInsets.only(right: 28.0),
          child: TextButton(
            onPressed: () => context.push('/profile'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                'assets/images/ryusihyun_profile.png',
                height: 35,
              ),
            ),
          ),
        ),
        titleText: '받은 편지함',
        body: ListView(children: [
          QueryBuilder(
            query: query,
            builder: (context, state) {
              return state.data == false
                  ? RequestNotificationPermissionWidget()
                  : Container();
            },
          ),
          if (_mailNum != 0)
            GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1.0,
                children: const [
                  MailWidget(isRead: 'false', date: "9.10"),
                  MailWidget(isRead: 'true', date: "9.09"),
                  MailWidget(isRead: 'true', date: "9.08"),
                  MailWidget(isRead: 'true', date: "9.07"),
                  MailWidget(isRead: 'true', date: "9.06"),
                  MailWidget(isRead: 'true', date: "9.05"),
                  MailWidget(isRead: 'true', date: "9.04"),
                  MailWidget(isRead: 'true', date: "9.03"),
                ])
          else
            Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  '🍂',
                  style: TextStyle(fontSize: 100),
                ),
                const SizedBox(height: 20),
                Text(
                  '아직 도착한 편지가 없어요. \n 내일 9시에 첫 편지가 올 거에요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorConstants.neutral, fontSize: 15, height: 1.5),
                )
              ],
            ),
        ]),
      ),
    );
  }
}
