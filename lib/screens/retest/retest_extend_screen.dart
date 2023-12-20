import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/actions.dart';
import 'package:project_june_client/widgets/retest/retest_choice_widget.dart';
import 'package:project_june_client/widgets/retest/retest_layout_widget.dart';

import '../../actions/auth/queries.dart';
import '../../actions/character/queries.dart';

class RetestExtendScreen extends StatelessWidget {
  final String firstName;

  const RetestExtendScreen({super.key, required this.firstName});

  @override
  Widget build(BuildContext context) {
    return QueryBuilder(
      query: getExtendCostQuery(),
      builder: (context, costState) {
        if (costState == null) return SizedBox.shrink();
        return RetestLayoutWidget(
          firstName: firstName,
          title: '${firstName}이와의 시간을 늘리려면,\n더 많은 비용이 필요해요.\n그래도 계속하시겠어요?',
          action: MutationBuilder(
            mutation: getExtendMutation(
              refetchQueries: [
                'my-character',
                "retrieve-me",
              ],
              onSuccess: (res, arg) {
                context.go('/character-test');
              },
            ), // TODO - 연장으로 바꿔야함
            builder: (context, state, mutate) {
              void handleRetest(String payment) {
                mutate(payment);
              }

              print(costState.data);
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
