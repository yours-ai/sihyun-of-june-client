import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/providers/common_provider.dart';
import 'package:project_june_client/providers/mail_list_provider.dart';
import 'package:project_june_client/services/unique_cachekey_service.dart';
import 'package:project_june_client/widgets/character_change_overlay_widget.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';
import 'package:project_june_client/widgets/mail_widget.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/notification/notification_permission_check.dart';

import '../../actions/character/models/Character.dart';
import '../../actions/mails/models/Mail.dart';
import '../../actions/mails/queries.dart';
import '../../actions/notification/queries.dart';
import '../../constants.dart';
import '../../services.dart';
import '../../widgets/common/alert/alert_widget.dart';
import '../../widgets/select_page_alert_widget.dart';
import '../character_profile/profile_details_screen.dart';

class MailListScreen extends ConsumerStatefulWidget {
  const MailListScreen({super.key});

  @override
  MailListScreenState createState() => MailListScreenState();
}

class MailListScreenState extends ConsumerState<MailListScreen>
    with TickerProviderStateMixin {
  int? selectedPage;
  int? lastMailId;
  bool? isLastMailReplied;
  DateTime? firstMailDate;
  List<Widget>? mailWidgetList;
  final GlobalKey _targetKey = GlobalKey();
  AnimationController? profileChangeController, reloadMailController;
  Animation<double>? profileChangeFadeAnimation, reloadMailFadeAnimation;
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();
    profileChangeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100), // 애니메이션 지속 시간
    );
    reloadMailController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // 애니메이션 지속 시간
    );
    profileChangeFadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(profileChangeController!);
    reloadMailFadeAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(reloadMailController!);
    checkRetest();
  }

  void checkRetest() async {
    final myCharacterList =
        await getRetrieveMyCharacterQuery().result.then((value) => value.data);
    final currentCharacter = myCharacterList!
        .where((character) => character.is_current == true)
        .first;
    final bool is30DaysFinished = await getRetrieveMeQuery()
        .result
        .then((value) => value.data!.is_30days_finished);
    if (!mounted) return;
    if (currentCharacter.id == ref.read(selectedCharacterProvider) &&
        is30DaysFinished) {
      context.push(
        "/retest",
        extra: <String, dynamic>{
          "firstName":
              characterService.getCurrentCharacterFirstName(myCharacterList),
          "characterIds": characterService.getCharacterIds(myCharacterList),
        },
      );
    }
  }

  void changeProfileList(List<Character> characterList) {
    final RenderObject? renderBox =
        _targetKey.currentContext?.findRenderObject();
    if (renderBox is RenderBox) {
      final Offset offset = renderBox.localToGlobal(Offset.zero);
      overlayEntry = OverlayEntry(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            hideOverlay();
          },
          child: FadeTransition(
            opacity: profileChangeFadeAnimation!,
            child: Material(
              color: Colors.black54,
              child: Stack(
                children: [
                  Positioned(
                    top: offset.dy - 7,
                    right: MediaQuery.of(context).size.width - offset.dx - 54,
                    child: Container(
                      width: 180,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        children: [
                          ...characterList
                              .where((character) =>
                                  character.id ==
                                  ref.watch(selectedCharacterProvider))
                              .map(
                                (character) => CharacterChangeOverlayWidget(
                                  character: character,
                                ),
                              )
                              .toList(),
                          ...characterList
                              .where((character) =>
                                  character.id !=
                                  ref.watch(selectedCharacterProvider))
                              .map(
                                (character) => CharacterChangeOverlayWidget(
                                  character: character,
                                  hideOverlay: hideOverlay,
                                  changeSelectedPageNull: changeSelectedPage,
                                ),
                              )
                              .toList(),
                          CharacterChangeOverlayWidget(
                            hideOverlay: hideOverlay,
                            changeSelectedPageNull: changeSelectedPage,
                            firstName: characterService
                                .getCurrentCharacterFirstName(characterList),
                            characterIds:
                                characterService.getCharacterIds(characterList),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
      Overlay.of(context).insert(overlayEntry!);
      profileChangeController!.forward();
    }
  }

  void hideOverlay() {
    profileChangeController!.reverse().then((_) {
      overlayEntry!.remove();
    });
  }

  void changeSelectedPage(int? index) {
    setState(() {
      selectedPage = index;
      ref.read(mailPageProvider.notifier).state = index;
    });
  }

  void updateAllMailList(List<Mail> mails) {
    if (mails.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          mailWidgetList = [];
          lastMailId = null;
          isLastMailReplied = null;
        });
      });
      return;
    }
    firstMailDate = mails.last.available_at;
    lastMailId = mails.first.id;
    isLastMailReplied = mails.first.replies!.isEmpty;
    final mailCount = mailService.checkMailNumber(mails);
    List<MailWidget> modifiedMailList = [];
    if (mailCount <= 30) {
      modifiedMailList = List.generate(
          30,
          (index) => MailWidget(
                mailNumber: index,
                firstMailDate: firstMailDate,
              ));
    } else {
      modifiedMailList = List.generate(
          mailCount,
          (index) => MailWidget(
                mailNumber: index,
                firstMailDate: firstMailDate,
              ));
    }
    for (var mail in mails) {
      int mailDateDiff =
          mailService.getMailDateDiff(mail.available_at, firstMailDate!);
      modifiedMailList[mailDateDiff] = MailWidget(
        mail: mail,
        mailNumber: mailDateDiff,
        firstMailDate: firstMailDate,
      );
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        mailWidgetList = fillMailList(modifiedMailList);
      });
    });
  }

  List<Widget> fillMailList(List<Widget> modifiedWidgetList) {
    List<Widget> emptyCellsForWeekDay = mailService
        .emptyCellsForWeekDay(firstMailDate!); //첫 번째 날짜의 요일에 따라 빈 칸을 채움
    return emptyCellsForWeekDay + modifiedWidgetList;
  }

  @override
  Widget build(context) {
    final isNotificationAcceptedQuery = getIsNotificationAcceptedQuery();
    final retrieveMyCharacterQuery = getRetrieveMyCharacterQuery();
    return SafeArea(
      child: QueryBuilder(
        query: retrieveMyCharacterQuery,
        builder: (context, charactersState) {
          if (charactersState.data == null) {
            return const SizedBox();
          }
          final selectedCharacter = charactersState.data!
              .where((character) =>
                  character.id == ref.watch(selectedCharacterProvider))
              .first;
          final mainImageSrc = characterService
              .getMainImage(selectedCharacter.character_info!.images!);
          if (selectedPage == null) {
            selectedPage = selectedCharacter.date_allocated!.length;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref.read(mailPageProvider.notifier).state =
                  selectedCharacter.date_allocated!.length;
            });
          }
          return TitleLayout(
            title: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        '${selectedCharacter.first_name}이와의\n${mailService.getDDay(selectedCharacter.date_allocated!.last)}',
                        style: TextStyle(
                          fontFamily: 'NanumJungHagSaeng',
                          color: ColorConstants.primary,
                          fontSize: 21,
                          height: 15 / 18.5,
                          letterSpacing: 2,
                          fontWeight: FontWeightConstants.semiBold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                const TitleUnderline(titleText: "받은 편지함"),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          selectedCharacter.is_image_updated!
                              ? showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => ProfileDetailsScreen(
                                    imageList: selectedCharacter
                                        .character_info!.images!,
                                    index: mainImageSrc.order - 1,
                                  ),
                                )
                              : context.push('/mails/my-character');
                        },
                        onLongPressStart: (_) {
                          HapticFeedback.heavyImpact();
                        },
                        onLongPressEnd: (_) {
                          HapticFeedback.heavyImpact();
                          changeProfileList(charactersState.data!);
                        },
                        child: Container(
                          key: _targetKey,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70.0),
                            // 원형 테두리 반경
                            border: Border.all(
                              color: selectedCharacter.is_image_updated!
                                  ? Color(ref
                                      .watch(characterThemeProvider)
                                      .colors!
                                      .primary!)
                                  : ColorConstants.background,
                              // 테두리 색상
                              width: 2.0, // 테두리 두께
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: ExtendedImage.network(
                                timeLimit:
                                    ref.watch(imageCacheDurationProvider),
                                cacheKey: UniqueCacheKeyService.makeUniqueKey(
                                    mainImageSrc.src),
                                mainImageSrc.src,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            body: QueryBuilder(
              query: getListMailQuery(
                  characterId: ref.watch(selectedCharacterProvider)!,
                  page: selectedPage!),
              builder: (context, listMailState) {
                if (listMailState.data != null) {
                  bool isFirstLoad = mailWidgetList == null;
                  bool isMailListEmpty = listMailState.data!.isEmpty;
                  int? currentFirstMailId =
                      isMailListEmpty ? null : listMailState.data!.first.id;
                  bool hasLastMailIdChanged = currentFirstMailId != lastMailId;
                  bool hasLastMailReplyStatusChanged =
                      listMailState.data!.isEmpty
                          ? false
                          : listMailState.data!.first.replies!.isEmpty !=
                              isLastMailReplied;

                  if (isFirstLoad ||
                      hasLastMailIdChanged ||
                      hasLastMailReplyStatusChanged) {
                    updateAllMailList(listMailState.data!);
                  }
                }
                return (selectedPage == null || mailWidgetList == null)
                    ? const CircularProgressIndicator.adaptive()
                    : Stack(
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
                            child: Column(
                              children: [
                                selectedCharacter.date_allocated!.length > 1
                                    ? SelectPageWidget(
                                        selectedPage: selectedPage,
                                        mailReceivedMonth: selectedCharacter
                                            .date_allocated!.length,
                                        changeSelectedPage: changeSelectedPage)
                                    : const SizedBox(height: 20),
                                if (mailWidgetList!.isEmpty == true)
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '아직 도착한 편지가 없어요!',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: ColorConstants.primary,
                                            fontSize: 21,
                                            height: 1,
                                            fontWeight:
                                                FontWeightConstants.semiBold,
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
                                    ),
                                  ),
                                if (mailWidgetList!.isEmpty == false) ...[
                                  mailService.calendarWeekday(),
                                  const SizedBox(height: 20),
                                  Expanded(
                                    child: RefreshIndicator.adaptive(
                                      onRefresh: () async {
                                        HapticFeedback.lightImpact();
                                        await retrieveMyCharacterQuery
                                            .refetch();
                                        await getListMailQuery(
                                                characterId: ref.watch(
                                                    selectedCharacterProvider)!,
                                                page: selectedPage!)
                                            .refetch();
                                        reloadMailController!
                                            .forward()
                                            .then((_) {
                                          reloadMailController!.reverse();
                                        });
                                      },
                                      child: FadeTransition(
                                        opacity: reloadMailFadeAnimation!,
                                        child: GridView.count(
                                          crossAxisCount: 7,
                                          childAspectRatio: 7 / 11,
                                          children: mailWidgetList!,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      );
              },
            ),
          );
        },
      ),
    );
  }
}
