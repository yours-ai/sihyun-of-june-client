import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/services/unique_cachekey_service.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';
import 'package:word_break_text/word_break_text.dart';

class RelationshipScreen extends ConsumerWidget {
  const RelationshipScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: QueryBuilder(
        query: fetchMyCharacterQuery(),
        builder: (context, myCharactersState) {
          if (myCharactersState.data == null) {
            return const SizedBox();
          }
          final selectedCharacterList = myCharactersState.data!.where(
              (character) =>
                  character.id == ref.watch(selectedCharacterProvider));
          if (selectedCharacterList.isEmpty) {
            if (myCharactersState.data!.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ref.read(selectedCharacterProvider.notifier).state =
                    myCharactersState.data!.first.id;
              });
            }
            return const SizedBox();
          }
          final selectedCharacter = selectedCharacterList.first;
          return SafeArea(
            child: TitleLayout(
              title: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => context.pop(),
                          icon: Icon(
                            PhosphorIcons.arrow_left,
                            color: ColorConstants.primary,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const TitleUnderline(
                    titleText: '사이',
                  ),
                  const Expanded(
                    flex: 1,
                    child: SizedBox.shrink(),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: '${selectedCharacter.first_name}이와 ',
                          style: TextStyle(
                            color: ColorConstants.primary,
                            fontFamily: 'NanumJungHagSaeng',
                            fontSize: 35,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: '아는 사이', //TODO: 무슨 사이인지 동적으로 바꿔야함
                              style: TextStyle(
                                color: ColorConstants.pink,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ExtendedImage.network(
                      selectedCharacter.character_info.images.first.src,
                      cacheMaxAge: CachingDuration.image,
                      cacheKey: UniqueCacheKeyService.makeUniqueKey(
                          selectedCharacter.character_info.images.first.src),
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                      cache: true,
                      loadStateChanged: (state) {
                        switch (state.extendedImageLoadState) {
                          case LoadState.loading:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case LoadState.completed:
                            return state.completedWidget;
                          case LoadState.failed:
                            return Center(
                              child: Icon(
                                PhosphorIcons.x_circle,
                                color: ColorConstants.alert,
                                size: 32,
                              ),
                            );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //TODO: 나중에 동적으로 바꿔야 함
                        Text(
                          '아는 사이',
                          style: TextStyle(
                            color: ColorConstants.gray,
                            fontFamily: 'Pretendard',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 5),
                        ..._buildRelationshipProgress(9, 4),
                        const SizedBox(width: 5),
                        Text(
                          '친한 사이',
                          style: TextStyle(
                            color: ColorConstants.gray,
                            fontFamily: 'Pretendard',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 110,
                                  child: Text.rich(
                                    textAlign: TextAlign.center,
                                    TextSpan(
                                      text: '내가 볼때 지금 둘의 사이는 딱\n',
                                      style: relationshipTextStyle,
                                      children: [
                                        TextSpan(
                                          text: '아는 사이',
                                          //TODO: 무슨 사이인지 동적으로 바꿔야함
                                          style: TextStyle(
                                            color: ColorConstants.pink,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                ColorConstants.pink,
                                            decorationThickness: 1,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: '야.',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 40),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const SizedBox(height: 45),
                                SizedBox(
                                  width: 170,
                                  child: WordBreakText(
                                    '학교 다닐 때, 서로 알고는 있지만 졸업하고 나면 다시는 볼 일 없는 그런 친구 있잖아? 그런 사이라고 할 수 있지.',
                                    style: relationshipTextStyle,
                                    textAlign: TextAlign.center,
                                    wrapAlignment: WrapAlignment.center,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 140,
                              child: WordBreakText(
                                '가볍게 서로에 대해 물어보면서 친해지는 건 어때?',
                                style: relationshipTextStyle,
                                textAlign: TextAlign.center,
                                wrapAlignment: WrapAlignment.center,
                              ),
                            ),
                            const SizedBox(width: 90),
                          ],
                        ),
                        const SizedBox(height: 30),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            '어떤 사이가 있는지 궁금하다면?',
                            style: TextStyle(
                              color: ColorConstants.mediumGray,
                              fontFamily: 'Pretendard',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              decorationColor: ColorConstants.mediumGray,
                              decoration: TextDecoration.underline,
                              decorationThickness: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

List<Widget> _buildRelationshipProgress(int fullCount, int currentCount) {
  final List<Widget> progressList = [];
  for (int i = 0; i < fullCount; i++) {
    progressList.add(
      Icon(
        PhosphorIcons.circle_fill,
        color: i < currentCount
            ? ColorConstants.mediumGray
            : ColorConstants.lightGray,
        size: 16,
      ),
    );
  }
  return progressList;
}

final relationshipTextStyle = TextStyle(
  color: ColorConstants.primary,
  fontFamily: 'NanumJungHagSaeng',
  fontSize: 22,
  fontWeight: FontWeight.w400,
);
