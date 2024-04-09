import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';
import 'package:word_break_text/word_break_text.dart';

class RelationshipScreen extends ConsumerWidget {
  const RelationshipScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCharacter = ref.watch(selectedCharacterProvider);
    if (selectedCharacter == null) {
      context.go(RoutePaths.home);
      return const SizedBox.shrink();
    }
    return Scaffold(
      body: SafeArea(
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
                            color:
                                Color(selectedCharacter.theme.colors.primary),
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
                  cacheKey: commonService.makeUniqueKey(
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
                        color: Color(selectedCharacter.theme.colors.primary),
                        fontFamily: 'Pretendard',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    ..._buildRelationshipProgress(
                      fullCount: 9,
                      currentCount: 4,
                      filledColor:
                          Color(selectedCharacter.theme.colors.primary),
                      emptyColor: Color(
                          selectedCharacter.theme.colors.inverse_on_surface),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '친한 사이',
                      style: TextStyle(
                        color: Color(selectedCharacter.theme.colors.primary),
                        fontFamily: 'Pretendard',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          text: '내가 볼때 지금 둘의 사이는 딱 ',
                          style: relationshipTextStyle,
                          children: [
                            TextSpan(
                              text: '아는 사이',
                              //TODO: 무슨 사이인지 동적으로 바꿔야함
                              style: TextStyle(
                                color: Color(
                                    selectedCharacter.theme.colors.primary),
                                decoration: TextDecoration.underline,
                                decorationColor: Color(
                                    selectedCharacter.theme.colors.primary),
                                decorationThickness: 1,
                              ),
                            ),
                            const TextSpan(
                              text: '야.',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 36),
                      WordBreakText(
                        '학교 다닐 때, 서로 알고는 있지만 졸업하고 나면 다시는 볼 일 없는 그런 친구 있잖아? 그런 사이라고 할 수 있지.',
                        style: relationshipTextStyle,
                        textAlign: TextAlign.center,
                        wrapAlignment: WrapAlignment.center,
                      ),
                      const SizedBox(height: 36),
                      WordBreakText(
                        '가볍게 서로에 대해 물어보면서 친해지는 건 어때?',
                        style: relationshipTextStyle,
                        textAlign: TextAlign.center,
                        wrapAlignment: WrapAlignment.center,
                      ),
                      const SizedBox(height: 36),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> _buildRelationshipProgress({
  required int fullCount,
  required int currentCount,
  required Color filledColor,
  required Color emptyColor,
}) {
  final List<Widget> progressList = [];
  for (int i = 0; i < fullCount; i++) {
    progressList.add(
      Icon(
        PhosphorIcons.circle_fill,
        color: i < currentCount ? filledColor : emptyColor,
        size: 16,
      ),
    );
  }
  return progressList;
}

final relationshipTextStyle = TextStyle(
  color: ColorConstants.primary,
  fontFamily: 'NanumJungHagSaeng',
  fontSize: 28,
  fontWeight: FontWeight.w400,
  height: 1,
);
