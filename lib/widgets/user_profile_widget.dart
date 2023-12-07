import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/providers/common_provider.dart';
import 'package:project_june_client/services/unique_cachekey_service.dart';

import '../actions/auth/queries.dart';
import '../actions/character/queries.dart';
import '../constants.dart';
import '../services.dart';

class UserProfileWidget extends ConsumerStatefulWidget {
  const UserProfileWidget({super.key});

  @override
  UserProfileWidgetState createState() => UserProfileWidgetState();
}

class UserProfileWidgetState extends ConsumerState<UserProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            QueryBuilder(
              query: getRetrieveMyCharacterQuery(),
              builder: (context, state) {
                if (state.data != null) {
                  final mainImageSrc = characterService.getMainImage(state
                      .data!
                      .first
                      .character_info!
                      .images!); //TODO 나중에는 first인 애들 선택한 캐릭터로 바꿔야함
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        context.push('/mails/my-character');
                      },
                      child: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadius.circular(66),
                        child: SizedBox(
                          width: 132,
                          height: 132,
                          child: ExtendedImage.network(
                            mainImageSrc,
                            timeLimit: ref.watch(imageCacheDurationProvider),
                            cacheKey: UniqueCacheKeyService.makeUniqueKey(
                                mainImageSrc),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            TextButton(
              onPressed: () {
                context.push('/mails/my-character');
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: ColorConstants.gray,
                      width: 1.0,
                    ),
                  ),
                ), // Text에 underline을 추가하면, 한글 이슈로 빈칸과 높낮이가 안 맞음.
                padding: const EdgeInsets.all(0),
                child: Text('프로필 보기',
                    style: TextStyle(color: ColorConstants.gray, height: 1.0)),
              ),
            ),
          ],
        ),
        Column(
          children: [
            QueryBuilder(
              query: getRetrieveMeQuery(),
              builder: (context, state) => state.data == null
                  ? const SizedBox.shrink()
                  : Center(
                      child: GestureDetector(
                        onTap: () {
                          userProfileService.showChangeImageModal(context, ref);
                        },
                        child: ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.circular(66),
                          child: SizedBox(
                            width: 132,
                            height: 132,
                            child: state.data!.image == null
                                ? Image.asset(
                                    'assets/images/default_user_image.png')
                                : ExtendedImage.network(
                                    state.data!.image!,
                                    timeLimit:
                                        ref.watch(imageCacheDurationProvider),
                                    cacheKey:
                                        UniqueCacheKeyService.makeUniqueKey(
                                            state.data!.image!),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ),
            ),
            TextButton(
              onPressed: () {
                userProfileService.showChangeImageModal(context, ref);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: ColorConstants.gray,
                      width: 1.0,
                    ),
                  ),
                ), // Text에 underline을 추가하면, 한글 이슈로 빈칸과 높낮이가 안 맞음.
                padding: const EdgeInsets.all(0),
                child: Text('프로필 변경하기',
                    style: TextStyle(color: ColorConstants.gray, height: 1.0)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
