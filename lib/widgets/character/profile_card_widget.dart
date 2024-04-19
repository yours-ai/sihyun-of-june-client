import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/models/character.dart';
import 'package:project_june_client/actions/character/models/character_image.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/providers/common_provider.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/character/custom_story_indicator_widget.dart';
import 'package:project_june_client/widgets/character/profile_list_widget.dart';

const double indicatorPadding = 15.0;

class ProfileCardWidget extends ConsumerStatefulWidget {
  final Character character;
  final int mainImageIndex;
  final ProfileWidgetType profileWidgetType;
  final List<Widget> children;
  final VoidCallback changeCharacterByLeftDrag;
  final VoidCallback changeCharacterByRightDrag;

  const ProfileCardWidget({
    super.key,
    required this.character,
    required this.mainImageIndex,
    required this.profileWidgetType,
    required this.children,
    required this.changeCharacterByLeftDrag,
    required this.changeCharacterByRightDrag,
  });

  @override
  ProfileCardWidgetState createState() => ProfileCardWidgetState();
}

class ProfileCardWidgetState extends ConsumerState<ProfileCardWidget> {
  late final imageIndex = ValueNotifier(widget.mainImageIndex);
  final CarouselController _imageListController = CarouselController();
  String questText = '';

  void _preloadImages(List<CharacterImage> imageList) {
    for (final image in imageList) {
      precacheImage(
        ExtendedNetworkImageProvider(
          image.src,
          cache: true,
          cacheMaxAge: CachingDuration.image,
          cacheKey: commonService.makeUniqueKey(image.src),
        ),
        context,
      );
    }
  }

  @override
  void didUpdateWidget(covariant ProfileCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadImages(widget.character.character_info.images);
    });
    _imageListController.jumpToPage(widget.mainImageIndex);
    setState(() {
      imageIndex.value = widget.mainImageIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadImages(widget.character.character_info.images);
    });
    imageIndex.addListener(() {
      setState(() {
        if (widget
            .character.character_info.images[imageIndex.value].is_blurred) {
          questText = widget
              .character.character_info.images[imageIndex.value].quest_text;
        } else {
          questText = '';
        }
      });
      if (imageIndex.value == 0) return;
      _imageListController.jumpToPage(imageIndex.value);
    });
  }

  @override
  void dispose() {
    imageIndex.dispose();
    super.dispose();
  }

  void startStoryAnimation(List<AnimationController> controllers) {
    for (AnimationController controller in controllers) {
      if (controller.status == AnimationStatus.forward) {
        controller.forward();
      }
    }
  }

  void stopStoryAnimation(List<AnimationController> controllers) {
    for (AnimationController controller in controllers) {
      if (controller.status == AnimationStatus.forward) {
        controller.stop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controllers = ref.watch(animationControllersProvider);
    final totalImageLength = widget.character.character_info.images.length;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          details.primaryVelocity! > 0
              ? widget.changeCharacterByLeftDrag()
              : widget.changeCharacterByRightDrag();
        },
        onTapDown: (_) {
          stopStoryAnimation(controllers);
        },
        onTapUp: (details) {
          startStoryAnimation(controllers);
          final double screenWidth = MediaQuery.of(context).size.width;
          final double dx = details.localPosition.dx;
          if (dx < screenWidth / 2) {
            if (imageIndex.value == 0) return;
            _imageListController.jumpToPage(imageIndex.value - 1);
            if (widget
                .character.character_info.images[imageIndex.value].is_blurred) {
              questText = widget
                  .character.character_info.images[imageIndex.value].quest_text;
            } else {
              questText = '';
            }
          } else {
            if (imageIndex.value == totalImageLength - 1) return;
            _imageListController.jumpToPage(imageIndex.value + 1);
            if (widget
                .character.character_info.images[imageIndex.value].is_blurred) {
              questText = widget
                  .character.character_info.images[imageIndex.value].quest_text;
            } else {
              questText = '';
            }
          }
        },
        onTapCancel: () {
          startStoryAnimation(controllers);
        },
        onLongPressStart: (_) {
          stopStoryAnimation(controllers);
        },
        onLongPressEnd: (_) {
          startStoryAnimation(controllers);
        },
        child: Stack(
          children: [
            CarouselSlider.builder(
              carouselController: _imageListController,
              itemCount: totalImageLength,
              options: CarouselOptions(
                scrollPhysics: const NeverScrollableScrollPhysics(),
                initialPage: widget.mainImageIndex,
                height: MediaQuery.of(context).size.height,
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    imageIndex.value = index;
                  });
                },
              ),
              itemBuilder: (context, index, realIndex) {
                final imageSrc =
                    widget.character.character_info.images[index].src;
                return ExtendedImage.network(
                  imageSrc,
                  cacheMaxAge: CachingDuration.image,
                  enableLoadState: false,
                  cacheKey: commonService.makeUniqueKey(imageSrc),
                  fit: BoxFit.cover,
                );
              },
            ),
            SafeArea(
              child: Stack(
                children: [
                  ...widget.children,
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(indicatorPadding),
                      child: CustomStoryIndicator(
                        itemCount: totalImageLength,
                        currentIndex: imageIndex,
                        defaultColor:
                            ColorConstants.background.withOpacity(0.3),
                        highlightColor:
                            ColorConstants.background.withOpacity(0.87),
                        indicatorSpacing: 6.0,
                        interval: const Duration(seconds: 4),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 155,
                    child: Padding(
                      padding: const EdgeInsets.all(21),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (questText.isNotEmpty)
                            Column(
                              children: [
                                Icon(
                                  PhosphorIcons.lock_bold,
                                  color: ColorConstants.background,
                                  size: 24,
                                ),
                                const SizedBox(height: 7),
                                Text(
                                  questText.replaceAll('\\n', '\n'),
                                  style: TextStyle(
                                    color: ColorConstants.background,
                                    fontSize: 14,
                                    height: 19 / 14,
                                    fontWeight: FontWeightConstants.semiBold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.1),
                              ],
                            ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: widget.character.name,
                                      style: const TextStyle(
                                        fontSize: 60,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: ' ',
                                      style: TextStyle(
                                        fontSize: 22,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '(${widget.character.character_info.age})',
                                      style: const TextStyle(
                                        fontSize: 50,
                                      ),
                                    ),
                                  ],
                                  style: TextStyle(
                                    fontFamily: 'NanumJungHagSaeng',
                                    fontWeight: FontWeight.normal,
                                    color: ColorConstants.background,
                                    height: 1.1,
                                    letterSpacing: .8,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(
                                  widget.character.character_info
                                      .summary_description,
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.45,
                                    fontWeight: FontWeight.w500,
                                    wordSpacing: -0.7,
                                    letterSpacing: 0.45,
                                    color: ColorConstants.background,
                                  ),
                                ),
                              ),
                              Text(
                                widget.character.character_info
                                    .one_line_description,
                                style: TextStyle(
                                  fontFamily: 'NanumJungHagSaeng',
                                  fontSize: 35,
                                  letterSpacing: 0.5,
                                  height: 1.3,
                                  fontWeight: FontWeight.normal,
                                  color: ColorConstants.background,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
