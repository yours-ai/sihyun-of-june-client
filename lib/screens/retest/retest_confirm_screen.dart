import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/widgets/retest/retest_choice_widget.dart';
import 'package:project_june_client/widgets/retest/retest_layout_widget.dart';

import '../../actions/character/queries.dart';
import '../../globals.dart';
import '../../providers/character_provider.dart';
import '../../services.dart';
import '../../widgets/common/create_snackbar.dart';

class RetestConfirmScreen extends ConsumerWidget {
  final String firstName;

  const RetestConfirmScreen({super.key, required this.firstName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RetestLayoutWidget(
      firstName: firstName,
      title: '이것이 $firstName이와의\n마지막 작별이 되어요.\n그래도 새로운 상대를\n만나시겠어요?',
      action: MutationBuilder(
        mutation: getRetestMutation(
          refetchQueries: [
            'my-character',
            "retrieve-me",
          ],
          onSuccess: (res, arg) {
            scaffoldMessengerKey.currentState?.showSnackBar(
              createSnackBar(
                snackBarText: transactionService.getPurchaseStateText(arg),
                characterColors: ref.watch(characterThemeProvider).colors!,
              ),
            );
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
