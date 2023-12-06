import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/providers/character_theme_provider.dart';
import 'package:project_june_client/providers/common_provider.dart';
import 'package:project_june_client/services/unique_cachekey_service.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';
import 'package:project_june_client/widgets/mail_widget.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/notification_permission_check.dart';

import '../../actions/mails/models/Mail.dart';
import '../../actions/mails/queries.dart';
import '../../actions/notification/queries.dart';
import '../../constants.dart';
import '../../services.dart';
import '../../widgets/common/alert/alert_widget.dart';

class MailListScreen extends ConsumerStatefulWidget {
  const MailListScreen({super.key});

  @override
  MailListScreenState createState() => MailListScreenState();
}

class MailListScreenState extends ConsumerState<MailListScreen> {
  int? mailReceivedMonth; //편지를 받은 개월 수, 1부터 시작
  int? selectedMonth; //0부터 시작
  DateTime? firstMailDate;
  List<Widget> mailWidgetList = [];

  void checkMailNumber(List<Mail> mails) {
    firstMailDate = mails.last.available_at;
    var lastMailDate = mails.first.available_at;
    var totalMailNumber =
        mailService.getMailDateDiff(lastMailDate, firstMailDate!) + 1;
    mailReceivedMonth = (totalMailNumber / 30).ceil();
  }

  Future<List<Widget>> updateAllMailList(List<Mail> mails) async {
    checkMailNumber(mails);
    mailWidgetList = List.generate(
        mailReceivedMonth! * 30,
        (index) => MailWidget(
              mailNumber: index,
              firstMailDate: firstMailDate,
            ));
    for (var mail in mails) {
      int mailDateDiff =
          mailService.getMailDateDiff(mail.available_at, firstMailDate!);
      mailWidgetList[mailDateDiff] = MailWidget(
        mail: mail,
        mailNumber: mailDateDiff,
        firstMailDate: firstMailDate,
      );
    }
    return mailWidgetList;
  }

  List<Widget> modifiedMailList(List<Widget> mailWidgetList) {
    var modifiedFirstMailDate =
        firstMailDate!.add(Duration(days: 30 * (selectedMonth!)));
    List<Widget> emptyCellsForWeekDay = mailService
        .emptyCellsForWeekDay(modifiedFirstMailDate); //첫 번째 날짜의 요일에 따라 빈 칸을 채움
    return emptyCellsForWeekDay +
        mailWidgetList.sublist(
            (selectedMonth!) * 30, (selectedMonth! + 1) * 30);
  }

  Future showSelectMonthAlert() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertWidget(
            content: SizedBox(
              width: 300,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: mailReceivedMonth,
                itemBuilder: (context, index) {
                  return FilledButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.only(bottom: 3)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        selectedMonth == index
                            ? Color(ref
                                .watch(characterThemeProvider)
                                .colors!
                                .primary!)
                            : ColorConstants.veryLightGray,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedMonth = index;
                      });
                      context.pop();
                    },
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        mailService.kMonthData(index + 1),
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'NanumJungHagSaeng',
                            color: selectedMonth == index
                                ? ColorConstants.background
                                : ColorConstants.neutral),
                      ),
                    ),
                  );
                },
              ),
            ),
            confirmText: '확인');
      },
    );
  }

  @override
  Widget build(context) {
    final isNotificationAcceptedQuery = getIsNotificationAcceptedQuery();
    final listMailQuery = getListMailQuery();
    final retrieveMyCharacterQuery = getRetrieveMyCharacterQuery();
    return SafeArea(
      child: QueryBuilder(
        query: listMailQuery,
        builder: (context, listMailState) {
          if (listMailState.data != null && listMailState.data!.isNotEmpty) {
            updateAllMailList(listMailState.data!);
            if (selectedMonth == null) {
              selectedMonth = mailReceivedMonth! - 1;
            }
          }
          return listMailState.data == null
              ? const SizedBox()
              : TitleLayout(
                  title: Row(
                    children: [
                      const Expanded(child: SizedBox()),
                      const TitleUnderline(titleText: "받은 편지함"),
                      QueryBuilder(
                        query: retrieveMyCharacterQuery,
                        builder: (context, state) {
                          if (state.data != null && state.data!.isNotEmpty) {
                            final mainImageSrc = characterService.getMainImage(
                                state.data![0].character_info!.images!);
                            return Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        context.push('/mails/my-character'),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: ExtendedImage.network(
                                          timeLimit: ref.watch(
                                              imageCacheDurationProvider),
                                          cacheKey: UniqueCacheKeyService
                                              .makeUniqueKey(mainImageSrc),
                                          mainImageSrc,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return const Expanded(child: SizedBox());
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
                              ? const RequestNotificationPermissionWidget()
                              : const SizedBox.shrink();
                        },
                      ),
                      Positioned.fill(
                        child: listMailState.data?.isEmpty == true
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '아직 도착한 편지가 없어요!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ColorConstants.primary,
                                      fontSize: 21,
                                      height: 1,
                                      fontWeight: FontWeightConstants.semiBold,
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Text(
                                    '${mailService.getNextMailReceiveTimeStr()}에 첫 편지가 올 거에요. \n 조금만 기다려 주세요 :)',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ColorConstants.neutral,
                                      fontSize: 16,
                                      height: 22 / 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  mailReceivedMonth != 1
                                      ? GestureDetector(
                                          onTap: () => showSelectMonthAlert(),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  mailService.kMonthData(
                                                      selectedMonth! + 1),
                                                  style: TextStyle(
                                                    fontSize: 32,
                                                    fontFamily:
                                                        'NanumJungHagSaeng',
                                                    color:
                                                        ColorConstants.primary,
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5.0, top: 5),
                                                  child: Icon(
                                                      PhosphorIcons
                                                          .caret_down_bold,
                                                      size: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : const SizedBox(height: 20),
                                  mailService.calendarWeekday(),
                                  const SizedBox(height: 20),
                                  Expanded(
                                    child: GridView.count(
                                      crossAxisCount: 7,
                                      childAspectRatio: 7 / 11,
                                      children:
                                          modifiedMailList(mailWidgetList),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
