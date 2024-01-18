import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/providers/one_link_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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
            ref.watch(deepLinkProvider)?.mediaSource.toString(),
        refCode: ref.watch(oneLinkProvider)?['af_sub1'] ??
            ref.watch(deepLinkProvider)?.afSub1.toString());
    return MutationBuilder(
      mutation: getLoginAsKakaoMutation(
        onSuccess: (res, arg) async {
          await getUserFunnelMutation()
              .mutate(funnelDTO)
              .then((_) => context.go('/'));
        },
        onError: (arg, error, callback) {
          if (error is PlatformException && error.code == "CANCELED") {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  '카카오 로그인을 취소했어요.',
                ),
              ),
            );
            return;
          }
          Sentry.captureException(error);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                '카카오 로그인 중 에러가 발생했어요.',
              ),
            ),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/kakao_icon.png',
                height: 15,
              ),
              const SizedBox(width: 8),
              const Text('카카오로 계속하기')
            ],
          ),
        );
      },
    );
  }
}
