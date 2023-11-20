import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/notification/queries.dart';

import '../constants.dart';
import 'modal_widget.dart';

class RequestNotificationPermissionWidget extends StatefulWidget {
  const RequestNotificationPermissionWidget({super.key});

  @override
  State<RequestNotificationPermissionWidget> createState() =>
      _RequestNotificationPermissionWidgetState();
}

class _RequestNotificationPermissionWidgetState
    extends State<RequestNotificationPermissionWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showModalBottomSheet<void>(
        context: context,
        useRootNavigator: true,
        builder: (BuildContext context) {
          final mutation = getRequestNotificationPermissionMutation(
            onSuccess: (res, arg) {
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
              choiceColumn: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ColorConstants.background),
                    ),
                    onPressed: () {
                      context.pop();
                    },
                    child: Text('취소',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: ColorConstants.neutral,
                        )),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  FilledButton(
                    onPressed: () => mutate(null),
                    child: Text(
                      '동의하기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeightConstants.semiBold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
