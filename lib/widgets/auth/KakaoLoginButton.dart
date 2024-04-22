import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/providers/one_link_provider.dart';
import 'package:project_june_client/widgets/common/modal/modal_description_widget.dart';
import 'package:project_june_client/widgets/common/modal/modal_widget.dart';

import '../../actions/analytics/dtos.dart';
import '../../actions/analytics/queries.dart';
import '../../actions/auth/queries.dart';

class KakaoLoginButton extends ConsumerWidget {
  const KakaoLoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserFunnelDTO funnelDTO = UserFunnelDTO(
        funnel: ref.watch(oneLinkProvider)?['media_source'] ??
            ref.watch(deepLinkProvider)?.mediaSource?.toString(),
        refCode: ref.watch(oneLinkProvider)?['af_sub1'] ??
            ref.watch(deepLinkProvider)?.afSub1?.toString());
    return MutationBuilder(
      mutation: loginAsKakaoMutation(
        onSuccess: (res, arg) async {
          await sendUserFunnelMutation()
              .mutate(funnelDTO)
              .then((_) => context.go(RoutePaths.starting));
        },
        onError: (arg, error, callback) {
          if (error is PlatformException && error.code == 'CANCELED') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  '카카오 로그인을 취소했어요.',
                ),
              ),
            );
            return;
          }
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return ModalWidget(
                title: '서비스 종료 예정으로\n더 이상 가입할 수 없어요.',
                choiceColumn: FilledButton(
                  onPressed: () => context.pop(),
                  child: const Text('알겠어요'),
                ),
              );
            },
          );
        },
      ),
      builder: (context, state, mutate) {
        return FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFFFFE500),
            foregroundColor: ColorConstants.primary,
          ),
          onPressed: () =>
              state.status != QueryStatus.loading ? mutate(null) : null,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/kakao_icon.png',
                  height: 15,
                ),
                const SizedBox(width: 8),
                const Text('카카오로 계속하기')
              ],
            ),
          ),
        );
      },
    );
  }
}
