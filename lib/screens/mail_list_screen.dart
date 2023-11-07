import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/widgets/mail_widget.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/notification_permission_check.dart';

import '../actions/mails/models/Mail.dart';
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
  List<Widget> updateMails(List<Mail> mails) {
    var firstMailDate = mails.last.available_at;
    List<Widget> mailWidgetList = List.generate(30, (index) => MailWidget(firstMailDate: firstMailDate, mailNumber: index,));
    for (var mail in mails) {
      var mailDateDiff =
          mailService.getMailDateDiff(mail.available_at, firstMailDate);
      mailWidgetList[mailDateDiff] =
          MailWidget(mail: mail, mailNumber: mailDateDiff);
    }
    List<Widget> emptyCellsForWeekDay = List.generate(
        (firstMailDate.weekday - DateTime.sunday) % 7, (index) => SizedBox());
    return emptyCellsForWeekDay + mailWidgetList;
  }

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
            Flexible(
              child: Text(
                '받은 편지함',
                style: TextStyle(
                    fontFamily: 'NanumJungHagSaeng',
                    fontSize: 39,
                    height: 36 / 39),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
            QueryBuilder(
              query: retrieveMyCharacterQuery,
              builder: (context, state) {
                if (state.data != null) {
                  return TextButton(
                    onPressed: () => context.push('/mails/my-character'),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        state.data![0].image,
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
                          '아직 도착한 편지가 없어요. \n ${mailService.getNextMailReceiveTimeStr()}에 첫 편지가 올 거에요.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorConstants.neutral,
                              fontSize: 15,
                              height: 1.5),
                        )
                      ],
                    );
                  }
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          for (var day in [
                            "Sun",
                            "Mon",
                            "Tue",
                            "Wed",
                            "Thu",
                            "Fri",
                            "Sat"
                          ])
                            Text(day,
                                style: TextStyle(color: ColorConstants.gray, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 7,
                          padding: const EdgeInsets.all(4.0),
                          mainAxisSpacing: 30.0,
                          children: state.data != null
                              ? updateMails(state.data!)
                              : [],
                        ),
                      ),
                    ],
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
