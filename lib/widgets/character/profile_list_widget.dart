import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/services/unique_cachekey_service.dart';
import 'package:project_june_client/widgets/character/character_cinematic_widget.dart';
import 'package:project_june_client/widgets/character/profile_card_widget.dart';

import '../../actions/character/queries.dart';

enum ProfileWidgetType {
  selection,
  test,
  myCharacterProfile,
}

class ProfileListWidget extends ConsumerStatefulWidget {
  final ProfileWidgetType profileWidgetType;
  final List<Character> characterList;
  final int? testId;

  const ProfileListWidget({
    super.key,
    required this.profileWidgetType,
    required this.characterList,
    this.testId,
  });

  @override
  ProfileListWidgetState createState() => ProfileListWidgetState();
}

class ProfileListWidgetState extends ConsumerState<ProfileListWidget> {
  int selectedIndex = 0;
  final CarouselController _characterListController = CarouselController();

  Widget _buildButton(ProfileWidgetType buttonType, Color primaryColor) {
    Widget buildInitialButton(String buttonText) {
      return FilledButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
        ),
        onPressed: () => Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder:
                  (BuildContext pageContext, animation, secondaryAnimation) =>
                      CharacterCinematicWidget(
                character: widget.profileWidgetType == ProfileWidgetType.test
                    ? widget.characterList
                        .first // test일때 배정된 캐릭터로만 가게끔. test screen에서 list를 배정된 캐릭터를 첫번째로 보내줌.
                    : widget.characterList[selectedIndex],
                profileWidgetType: widget.profileWidgetType,
                testId: widget.testId,
              ),
              transitionDuration: const Duration(seconds: 1),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  ),
                  child: child,
                );
              },
            )),
        child: Text(buttonText),
      );
    }

    switch (buttonType) {
      case ProfileWidgetType.selection:
        return buildInitialButton('이 친구로 선택할래요!');
      case ProfileWidgetType.test:
        return buildInitialButton(
            '${widget.characterList.first.first_name}이로 배정완료 하기');
      case ProfileWidgetType.myCharacterProfile:
        return buildInitialButton('프로필 보기');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final selectedCharacterId = ref.watch(selectedCharacterProvider);
      final isImageUpdated = widget.characterList
              .where((character) => character.id == selectedCharacterId)
              .isNotEmpty &&
          (widget.characterList
                  .firstWhere(
                      (character) => character.id == selectedCharacterId)
                  .is_image_updated ??
              false);
      if (widget.profileWidgetType == ProfileWidgetType.myCharacterProfile &&
          selectedCharacterId != null &&
          isImageUpdated) {
        getReadCharacterStoryMutation(
          refetchQueries: ['my-character'],
        ).mutate(selectedCharacterId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainImageIndex = widget
        .characterList[selectedIndex].character_info.images
        .indexWhere((element) => element.is_main);
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Positioned.fill(
                child: ProfileCardWidget(
                  character: widget.characterList[selectedIndex],
                  profileWidgetType: widget.profileWidgetType,
                  mainImageIndex: mainImageIndex,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 176,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CarouselSlider.builder(
                      itemCount: widget.characterList.length,
                      carouselController: _characterListController,
                      options: CarouselOptions(
                        height: 78,
                        enableInfiniteScroll: false,
                        viewportFraction: 0.2,
                        onPageChanged: (index, reason) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      ),
                      itemBuilder: (context, index, realIndex) {
                        final bool isSelected = index == selectedIndex;
                        final character = widget.characterList[index];
                        final mainImageSrc = characterService
                            .getMainImage(character.character_info.images)
                            .src;
                        return GestureDetector(
                          onTap: () {
                            _characterListController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Opacity(
                            opacity: isSelected ? 0.8 : 0.3,
                            child: Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60.0),
                                    // 원형 테두리 반경
                                    border: isSelected
                                        ? Border.all(
                                            color: Color(
                                                character.theme.colors.primary),
                                            // 테두리 색상
                                            width: 2.0, // 테두리 두께
                                          )
                                        : null,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: ExtendedImage.network(
                                      cacheMaxAge: CachingDuration.image,
                                      cacheKey:
                                          UniqueCacheKeyService.makeUniqueKey(
                                              mainImageSrc),
                                      mainImageSrc,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  character.name,
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 14 / 12,
                                    color: Colors.white,
                                    fontWeight: isSelected
                                        ? FontWeightConstants.semiBold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(28, 18, 28, 18),
                      child: _buildButton(
                        widget.profileWidgetType,
                        Color(
                          widget.characterList[selectedIndex].theme.colors
                              .primary,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}