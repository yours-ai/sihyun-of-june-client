import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/widgets/retest/retest_choice_widget.dart';
import 'package:project_june_client/widgets/retest/retest_layout_widget.dart';

import '../../actions/auth/queries.dart';
import '../../actions/character/queries.dart';

class RetestConfirmScreen extends StatelessWidget {
  final String firstName;

  const RetestConfirmScreen({super.key, required this.firstName});

  @override
  Widget build(BuildContext context) {
    return RetestLayoutWidget(
      firstName: firstName,
      title: '이것이 ${firstName}이와의\n마지막 작별이 되어요.\n그래도 새로운 상대를\n만나시겠어요?',
      action: MutationBuilder(
        mutation: getRetestMutation(
          refetchQueries: [
            'my-character',
            "retrieve-me",
          ],
          onSuccess: (res, arg) {
            context.go('/character-test');
          },
        ),
        builder: (context, state, mutate) {
          void handleRetest(String payment) {
            mutate(payment);
          }

          return RetestChoiceWidget(
            inModal: true,
            onRetest: handleRetest,
          );
        },
      ),
    );
  }
}
