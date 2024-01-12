import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/widgets/common/modal/modal_choice_widget.dart';
import 'package:project_june_client/widgets/retest/retest_layout_widget.dart';

class RetestConfirmScreen extends ConsumerWidget {
  final String firstName;

  const RetestConfirmScreen({super.key, required this.firstName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RetestLayoutWidget(
        firstName: firstName,
        title: '이것이 $firstName이와의\n마지막 작별이 되어요.\n그래도 새로운 상대를\n만나시겠어요?',
        action: ModalChoiceWidget(
          submitText: '좋아요',
          cancelText: '아니요',
          onSubmit: () {
            context.go('/assignment');
          },
          onCancel: () {
            context.pop();
          },
        ));
  }
}
