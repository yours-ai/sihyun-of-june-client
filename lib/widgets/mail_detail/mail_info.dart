import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/providers/common_provider.dart';
import 'package:project_june_client/services/unique_cachekey_service.dart';

import '../../constants.dart';
import '../../services.dart';

class MailInfoWidget extends ConsumerWidget {
  final String? byImage;
  final String toFullName;
  final String byFullName;
  final DateTime availableAt;
  final bool isMe;

  const MailInfoWidget({
    Key? key,
    required this.byImage,
    required this.toFullName,
    required this.byFullName,
    required this.availableAt,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      textDirection: isMe ? TextDirection.rtl : TextDirection.ltr,
      children: [
        if (byImage != null) ...[
          GestureDetector(
            onTap: () {
              if (!isMe) {
                context.push('/mails/my-character');
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SizedBox(
                width: 46,
                height: 46,
                child: ExtendedImage.network(
                  timeLimit: ref.watch(imageCacheDurationProvider),
                  cacheKey: UniqueCacheKeyService.makeUniqueKey(byImage!),
                  byImage!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          )
        ] else ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              'assets/images/default_user_image.png',
              height: 46,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
        Expanded(
          child: Row(
            textDirection: isMe ? TextDirection.rtl : TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    'From. $byFullName',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 12,
                      fontWeight: FontWeightConstants.semiBold,
                      color: ColorConstants.gray,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'To. $toFullName',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 12,
                      fontWeight: FontWeightConstants.semiBold,
                      color: Color(
                          ref.watch(characterThemeProvider).colors!.primary!),
                    ),
                  ),
                ],
              ),
              Text(
                mailService.formatMailDate(availableAt),
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 12,
                  fontWeight: FontWeightConstants.semiBold,
                  color: ColorConstants.gray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
