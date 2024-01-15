import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/models/CharacterImage.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/providers/common_provider.dart';
import 'package:project_june_client/services/unique_cachekey_service.dart';

class ProfileDetailsScreen extends ConsumerStatefulWidget {
  final List<CharacterImage> imageList;
  final int? index;
  final bool? isImageUpdated;

  const ProfileDetailsScreen({
    required this.imageList,
    this.index,
    super.key,
    required this.isImageUpdated,
  });

  @override
  ProfileDetailsScreenView createState() => ProfileDetailsScreenView();
}

class ProfileDetailsScreenView extends ConsumerState<ProfileDetailsScreen> {
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.index ?? 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.watch(selectedCharacterProvider) != null &&
          widget.isImageUpdated != null &&
          widget.isImageUpdated!) {
        getReadCharacterStoryMutation(
          refetchQueries: ['my-character'],
        ).mutate(ref.watch(selectedCharacterProvider));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: ref.watch(topPaddingProvider),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () => context.pop(),
                            icon: const Icon(
                              PhosphorIcons.x_bold,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        '${_currentPage + 1}/${widget.imageList.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Pretendard',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox.shrink())
                ],
              ),
              Expanded(
                child: ExtendedImageGesturePageView.builder(
                  controller:
                      ExtendedPageController(initialPage: widget.index ?? 0),
                  itemCount: widget.imageList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (widget.imageList[index].is_blurred == true) {
                      return Stack(
                        children: [
                          Positioned.fill(
                            child: ExtendedImage.network(
                              widget.imageList[index].src,
                              fit: BoxFit.fitWidth,
                              mode: ExtendedImageMode.gesture,
                              enableSlideOutPage: true,
                              cacheMaxAge:
                                  ref.watch(imageCacheDurationProvider),
                              cacheKey: UniqueCacheKeyService.makeUniqueKey(
                                  widget.imageList[index].src),
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              color: Colors.black.withOpacity(0.9),
                            ),
                          ),
                          Positioned.fill(
                            child: Center(
                              child: Text(
                                widget.imageList[index].quest_text
                                    .replaceAll("\\n", "\n"),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Pretendard',
                                  fontSize: 25,
                                  height: 35 / 25,
                                  fontWeight: FontWeightConstants.semiBold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return ExtendedImage.network(
                        widget.imageList[index].src,
                        fit: BoxFit.fitWidth,
                        mode: ExtendedImageMode.gesture,
                        enableSlideOutPage: true,
                        cacheMaxAge: ref.watch(imageCacheDurationProvider),
                        cacheKey: UniqueCacheKeyService.makeUniqueKey(
                            widget.imageList[index].src),
                        initGestureConfigHandler: (state) {
                          return GestureConfig(
                            minScale: 1.0,
                            animationMinScale: 0.7,
                            maxScale: 3.0,
                            animationMaxScale: 3.5,
                            speed: 1.0,
                            inertialSpeed: 100.0,
                            inPageView: true,
                            initialScale: 1.0001,
                            // 안드로이드에서 줌된 상태에서는 확대가 매우 잘됩니다. 유저가 알아볼수없는 정도로 확대해놓았습니다
                            cacheGesture: false,
                          );
                        },
                      );
                    }
                  },
                  onPageChanged: (int index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
