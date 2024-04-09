import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/analytics/queries.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';
import 'package:share_plus/share_plus.dart';

import '../../actions/auth/queries.dart';
import '../../constants.dart';
import '../../providers/character_provider.dart';
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
            children: [
              const Center(child: TitleUnderline(titleText: '초대하기')),
              const SizedBox(height: 70),
              RichText(
                text: TextSpan(
                  text: '300포인트',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(ref
                            .watch(selectedCharacterProvider)
                            ?.theme
                            .colors
                            .primary ??
                        ProjectConstants.defaultTheme.colors.primary),
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '를 드려요!',
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
                '초대받은 친구가 가입하면\n보상을 받으실 수 있어요.',
                style: TextStyle(
                  fontSize: 16,
                  color: ColorConstants.gray,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Text(
                '(나에게 300포인트, 친구에게 200포인트)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: ColorConstants.gray,
                ),
              ),
              const SizedBox(height: 60),
              QueryBuilder(
                query: fetchReferralCodeQuery(),
                builder: (context, state) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        shareService.kakaoShare(state.data!);
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFFFE500),
                            ),
                            height: 54,
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/images/kakao_icon.png',
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
                    ),
                    const SizedBox(width: 50),
                    MutationBuilder(
                      mutation:
                          convertShorterUrlMutation(onSuccess: (res, arg) {
                        Share.share(
                            '${FirebaseRemoteConfig.instance.getString('referral_text').replaceAll("\\n", "\n")}\n$res',
                            subject: '유월의 시현이 공유하기');
                      }),
                      builder: (context, urlState, mutate) {
                        return GestureDetector(
                          onTap: () {
                            mutate(
                                'https://sihyunofjuneapp.onelink.me/i6rb/1m6u5hyx?af_sub1=${state.data}');
                          },
                          child: Column(
                            children: [
                              Container(
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
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
