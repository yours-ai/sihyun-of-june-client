import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/character/models/CharacterCinematic.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/globals.dart';
import 'package:project_june_client/services/unique_cachekey_service.dart';
import 'package:project_june_client/widgets/character/profile_list_widget.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class CharacterCinematicWidget extends StatefulWidget {
  final Character character;
  final ProfileWidgetType profileWidgetType;
  final int? testId;

  const CharacterCinematicWidget({
    required this.character,
    required this.profileWidgetType,
    this.testId,
    super.key,
  });

  @override
  State<CharacterCinematicWidget> createState() =>
      _CharacterCinematicWidgetState();
}

class _CharacterCinematicWidgetState extends State<CharacterCinematicWidget> {
  late final CharacterCinematic modifiedCharacterCinematic;
  bool isLastPage = false;
  int textIndex = 0;

  @override
  void initState() {
    super.initState();
    final characterCinematic = widget.character.character_info.cinematic;
    modifiedCharacterCinematic = CharacterCinematic(
        cinematic_background_image_1:
            characterCinematic.cinematic_background_image_1,
        cinematic_background_image_2:
            characterCinematic.cinematic_background_image_2,
        cinematic_description: [
          ...characterCinematic.cinematic_description,
          characterCinematic.cinematic_description.last
        ]);
  }

  void _onNextPage() {
    if (isLastPage) return;
    if (textIndex ==
        modifiedCharacterCinematic.cinematic_description.length - 2) {
      isLastPage = true;
    }
    setState(() {
      textIndex += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundImageSrc = isLastPage
        ? modifiedCharacterCinematic.cinematic_background_image_2
        : modifiedCharacterCinematic.cinematic_background_image_1;
    if (isLastPage) {
      Future.delayed(
        const Duration(milliseconds: 1500),
        () {
          if (!mounted) return;
          if (widget.profileWidgetType case ProfileWidgetType.selection) {
            context.go(
              RoutePaths.selectionConfirm,
              extra: {
                'id': widget.character.id,
                'firstName': widget.character.first_name,
                'primaryColor': widget.character.theme.colors.primary,
                'secondaryColor': widget.character.theme.colors.secondary,
              },
            );
          } else if (widget.profileWidgetType case ProfileWidgetType.test) {
            final int testId = widget.testId ?? -1;
            if (testId == -1) {
              Sentry.captureException('testId is null');
              scaffoldMessengerKey.currentState?.showSnackBar(
                const SnackBar(
                  content: Text(
                    '배정에 문제가 발생했습니다. 어플을 재시작해주세요.',
                  ),
                ),
              );
              return;
            }
            context.go(
              RoutePaths.testConfirm,
              extra: {
                'selectedCharacterId': widget.character.id,
                'testId': widget.testId,
                'selectedCharacterFirstName': widget.character.first_name,
                'selectedCharacterTheme': widget.character.theme,
              },
            );
          } else if (widget.profileWidgetType
              case ProfileWidgetType.myCharacterProfile) {
            context.pop();
          }
        },
      );
    }
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: GestureDetector(
            onTapUp: (details) {
              final double screenWidth = MediaQuery.of(context).size.width;
              final double dx = details.localPosition.dx;
              if (dx < screenWidth / 2) {
                if (textIndex == 0 || isLastPage) return;
                setState(() {
                  textIndex -= 1;
                });
              } else {
                _onNextPage();
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: ExtendedImage.network(
                    backgroundImageSrc,
                    key: ValueKey<bool>(isLastPage),
                    cacheMaxAge: CachingDuration.image,
                    enableLoadState: false,
                    cacheKey:
                        UniqueCacheKeyService.makeUniqueKey(backgroundImageSrc),
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: textIndex == 0
                        ? FutureBuilder(
                            future: Future.delayed(
                                const Duration(milliseconds: 2000)),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return _buildAnimatedText(
                                  modifiedCharacterCinematic
                                      .cinematic_description[textIndex],
                                  textIndex,
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          )
                        : _buildText(
                            modifiedCharacterCinematic
                                .cinematic_description[textIndex],
                            textIndex,
                          ),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 18,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    child: isLastPage
                        ? const SizedBox.shrink()
                        : FilledButton(
                            key: ValueKey<bool>(isLastPage),
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                  Size.fromWidth(
                                      MediaQuery.of(context).size.width - 56)),
                              backgroundColor: MaterialStateProperty.all(
                                  ColorConstants.darkGray),
                            ),
                            onPressed: _onNextPage,
                            child: const Text('다음'),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static final textStyle = TextStyle(
    color: ColorConstants.background,
    fontSize: 19,
    height: 27 / 19,
    fontWeight: FontWeightConstants.semiBold,
  );

  Widget _buildAnimatedText(String text, int index) {
    return AnimatedTextKit(
      key: ValueKey<int>(index),
      animatedTexts: [
        TyperAnimatedText(
          text,
          textStyle: textStyle,
          textAlign: TextAlign.center,
          speed: const Duration(milliseconds: 100),
        ),
      ],
      isRepeatingAnimation: false,
    );
  }

  Widget _buildText(String text, int index) {
    return Text(
      key: ValueKey<int>(index),
      text,
      style: textStyle,
      textAlign: TextAlign.center,
    );
  }
}