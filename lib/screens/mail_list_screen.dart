import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';
import 'package:project_june_client/widgets/mail_widget.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/notification_permission_check.dart';

import '../actions/mails/queries.dart';
import '../actions/notification/queries.dart';
import '../constants.dart';
import '../services.dart';

class MailListScreen extends StatefulWidget {
  const MailListScreen({super.key});

  @override
  State<MailListScreen> createState() => _MailListScreenState();
}

class _MailListScreenState extends State<MailListScreen> {
  @override
  Widget build(context) {
    final isNotificationAcceptedQuery = getIsNotificationAcceptedQuery();
    final listMailQuery = getListMailQuery();
    final retrieveMyCharacterQuery = getRetrieveMyCharacterQuery();
    return SafeArea(
      child: TitleLayout(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TitleUnderline(titleText: '받은 편지함'),
            QueryBuilder(
              query: retrieveMyCharacterQuery,
              builder: (context, state) {
                if (state.data != null) {
                  return TextButton(
                    onPressed: () => context.push('/mails/my-character'),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        state.data![0].default_image,
                        height: 35,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            QueryBuilder(
              query: isNotificationAcceptedQuery,
              builder: (context, state) {
                return state.data == false
                    ? RequestNotificationPermissionWidget()
                    : const SizedBox.shrink();
              },
            ),
            Positioned.fill(
              child: QueryBuilder(
                query: listMailQuery,
                builder: (context, state) {
                  if (state.data?.isEmpty == true) {
                    return Column(
                      children: [
                        const SizedBox(height: 50),
                        const Text(
                          '🍂',
                          style: TextStyle(fontSize: 100),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '아직 도착한 편지가 없어요. \n ${mailService
                              .getNextMailReceiveTimeStr()}에 첫 편지가 올 거에요.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorConstants.neutral,
                              fontSize: 15,
                              height: 1.5),
                        )
                      ],
                    );
                  }
                  return GridView.count(
                    crossAxisCount: 3,
                    padding: const EdgeInsets.all(20.0),
                    children: state.data
                        ?.map<Widget>((mail) => MailWidget(mail: mail))
                        .toList() ??
                        [],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
