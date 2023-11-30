import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';
import 'package:project_june_client/widgets/menu_widget.dart';
import 'package:share_plus/share_plus.dart';

import '../../actions/auth/queries.dart';
import '../../constants.dart';
import '../../providers/character_theme_provider.dart';
import '../../services.dart';

class ShareScreen extends ConsumerWidget {
  const ShareScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const BackAppbar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: TitleUnderline(titleText: '공유하기')),
              const SizedBox(height: 70),
              RichText(
                text: TextSpan(
                  text: '50코인',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(
                        ref.watch(characterThemeProvider).colors!.primary!),
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '을 드려요!',
                      style: TextStyle(
                        fontSize: 20,
                        color: ColorConstants.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                '초대받은 친구가 가입하면\n코인을 받으실 수 있어요.',
                style: TextStyle(
                  fontSize: 16,
                  color: ColorConstants.gray,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                '(링크로 친구 가입 완료시 50코인 지급)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: ColorConstants.gray,
                ),
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 54,
                          padding: const EdgeInsets.all(10),
                          color: const Color(0xFFFFE500),
                          child: Image.asset(
                            'assets/images/kakao_icon.png',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '카카오톡으로\n공유하기',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: ColorConstants.gray,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 50),
                  QueryBuilder(
                    query: getRefferalCodeQuery(),
                    builder: (context, state) => GestureDetector(
                      onTap: () {
                        Share.share(
                            '[유월의 시현이]\n\n기다려본 적 있나요? 하루 한 통의 설렘을. 사람보다 더 따뜻하고 섬세한 당신의 시현이에게, 지금 첫 편지를 받아보세요.\nhttps://sihyunofjuneapp.onelink.me/i6rb/ielenera?af_sub1=${state.data}',
                            subject: '유월의 시현이 공유하기');
                      },
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: ColorConstants.primary,
                                ),
                              ),
                              child: const Icon(
                                PhosphorIcons.share_network_fill,
                                size: 32,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '링크로\n공유하기',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: ColorConstants.gray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
