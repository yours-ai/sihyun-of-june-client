import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/modal/modal_choice_widget.dart';
import 'package:project_june_client/widgets/common/modal/modal_description_widget.dart';
import 'package:project_june_client/widgets/common/modal/modal_widget.dart';

import '../../providers/user_provider.dart';

class RetestModalWidget extends ConsumerWidget {
  final String? firstName;

  const RetestModalWidget({super.key, required this.firstName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isEnableToRetest = ref.read(isEnableToRetestProvider);
    return ModalWidget(
      title: isEnableToRetest
          ? '아직 $firstName이와의 시간이 남았어요.\n그래도 새 친구를 만나시겠어요?'
          : '모든 상대를 만나보셨군요!',
      description: ModalDescriptionWidget(
        description: isEnableToRetest
            ? '$firstName이와의 기억이 지워지고,\n더 이상 편지를 받아볼 수 없어요.'
            : '현재 상대하고만 편지를 주고받을 수 있어요.',
      ),
      choiceColumn: isEnableToRetest
          ? ModalChoiceWidget(
              submitText: '네',
              cancelText: '아니요',
              onSubmit: () async => context.go(RoutePaths.assignment),
              onCancel: () async => context.pop(),
            )
          : FilledButton(
              onPressed: () => context.pop(),
              child: const Text('알겠어요'),
            ),
    );
  }
}
