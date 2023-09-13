import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/widgets/mail_widget.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/notification_permission_check.dart';

import '../actions/mails/queries.dart';
import '../actions/notification/queries.dart';
import '../constants.dart';

class MailListScreen extends StatefulWidget {
  const MailListScreen({super.key});

  @override
  State<MailListScreen> createState() => _MailListScreenState();
}

class _MailListScreenState extends State<MailListScreen> {
  @override
  Widget build(context) {
    final query = getIsNotificationAcceptedQuery();
    return SafeArea(
      child: TitleLayout(
        showProfile: Padding(
          padding: const EdgeInsets.only(right: 28.0),
          child: QueryBuilder(
            query: getMyCharacterQuery(),
            builder: (context, state) {
              if (state.data != null) {
                return TextButton(
                  onPressed: () => context.push('/profile'),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(
                      state.data![0].image,
                      height: 35,
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
        titleText: '받은 편지함',
        body: ListView(
          children: [
            QueryBuilder(
              query: query,
              builder: (context, state) {
                return state.data == false
                    ? RequestNotificationPermissionWidget()
                    : Container();
              },
            ),
            QueryBuilder(
              query: getMailListQuery(),
              builder: (context, state) {
                if (state.data?.length == 0) {
                  return Column(
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
                            color: ColorConstants.neutral,
                            fontSize: 15,
                            height: 1.5),
                      )
                    ],
                  );
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(20.0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.data?.length ?? 0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    if (state.data!.length != 0) {
                      return MailWidget(mail: state.data![index]);
                    }
                    else {
                      return Container();
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
