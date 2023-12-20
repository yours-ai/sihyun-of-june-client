import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/widgets/retest/retest_choice_widget.dart';
import 'package:project_june_client/widgets/retest/retest_layout_widget.dart';

import '../../actions/character/queries.dart';
import '../../globals.dart';
import '../../widgets/common/create_snackbar.dart';

class RetestExtendScreen extends ConsumerWidget {
  final String firstName;

  const RetestExtendScreen({super.key, required this.firstName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return QueryBuilder(
      query: getExtendCostQuery(),
      builder: (context, costState) {
        return RetestLayoutWidget(
          firstName: firstName,
          title: '$firstName이와의 시간을 늘리려면,\n더 많은 비용이 필요해요.\n그래도 계속하시겠어요?',
          action: MutationBuilder(
            mutation: getExtendMutation(
              refetchQueries: [
                'my-character',
                "retrieve-me",
              ],
              onSuccess: (res, arg) {
                scaffoldMessengerKey.currentState?.showSnackBar(
                  createSnackBar(
                    snackBarText: arg == 'coin'
                        ? '${costState.data!['coin']}코인을 사용했어요!'
                        : '${costState.data!['point']}포인트를 사용했어요!}',
                    characterColors: ref.watch(characterThemeProvider).colors!,
                  ),
                );
                context.go('/');
              },
            ),
            builder: (context, state, mutate) {
              void handleRetest(String payment) {
                mutate(payment);
              }

              return RetestChoiceWidget(
                onRetest: handleRetest,
                extendCost: costState.data,
              );
            },
          ),
        );
      },
    );
  }
}
