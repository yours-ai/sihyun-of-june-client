import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/notification/queries.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/common/modal/modal_choice_widget.dart';
import 'package:project_june_client/widgets/common/modal/modal_widget.dart';

class RequestNotificationPermissionWidget extends ConsumerStatefulWidget {
  const RequestNotificationPermissionWidget({super.key});

  @override
  RequestNotificationPermissionWidgetState createState() =>
      RequestNotificationPermissionWidgetState();
}

class RequestNotificationPermissionWidgetState
    extends ConsumerState<RequestNotificationPermissionWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        showModalBottomSheet<void>(
          context: context,
          useRootNavigator: true,
          builder: (BuildContext context) {
            final mutation = requestNotificationPermissionMutation(
              onSuccess: (res, arg) {
                if (!mounted) return;
                // notificationService.initializeNotificationHandlers(ref); // login provider생기면 바꾸자.
                context.pop();
              },
              onError: (arg, err, fallback) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('알림 동의를 받지 못했어요. 기기 설정에서 알림을 허용해주세요.'),
                  ),
                );
                context.pop();
              },
            );
            return MutationBuilder(
              mutation: mutation,
              builder: (context, state, mutate) => ModalWidget(
                title: '편지를 받으려면,\n알림 동의가 필요해요',
                choiceColumn: ModalChoiceWidget(
                  submitText: '동의하기',
                  onSubmit: () => mutate(null),
                  cancelText: '취소',
                  onCancel: () => context.pop(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
