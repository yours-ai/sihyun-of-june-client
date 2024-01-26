import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_june_client/actions/character/models/CharacterCinematic.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/services/unique_cachekey_service.dart';
import 'package:project_june_client/widgets/character/profile_list_widget.dart';

class CharacterCinematicWidget extends StatefulWidget {
  final CharacterCinematic characterCinematic;
  final ProfileWidgetType profileWidgetType;

  const CharacterCinematicWidget({
    required this.characterCinematic,
    required this.profileWidgetType,
    super.key,
  });

  @override
  State<CharacterCinematicWidget> createState() =>
      _CharacterCinematicWidgetState();
}

class _CharacterCinematicWidgetState extends State<CharacterCinematicWidget> {
  int textIndex = 0;
  final ExtendedPageController _cinematicController = ExtendedPageController();

  @override
  Widget build(BuildContext context) {
    final totalPage = widget.characterCinematic.text.length;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: ExtendedImageGesturePageView.builder(
            itemCount: totalPage,
            controller: _cinematicController,
            itemBuilder: (context, index) {
              final isLastPage = index == totalPage - 1;
              final backgroundImageSrc = isLastPage
                  ? widget.characterCinematic.background.finish
                  : widget.characterCinematic.background.main;
              return GestureDetector(
                onTapUp: (details) {
                  final double screenWidth = MediaQuery.of(context).size.width;
                  final double dx = details.localPosition.dx;
                  if (dx < screenWidth / 2) {
                    if (textIndex == 0) return;
                    _cinematicController.jumpToPage(textIndex - 1);
                  } else {
                    if (isLastPage) {
                      //TODO: animation 후 push
                      return;
                    }
                    _cinematicController.jumpToPage(textIndex + 1);
                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: ExtendedImage.network(
                        backgroundImageSrc,
                        cacheMaxAge: CachingDuration.image,
                        enableLoadState: false,
                        cacheKey: UniqueCacheKeyService.makeUniqueKey(
                            backgroundImageSrc),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      //TODO: 조정 필요. gpt가 만들어준거임
                      bottom: 0,
                      child: Text(
                        widget.characterCinematic.text[index],
                        style: TextStyle(
                          color: ColorConstants.background,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
