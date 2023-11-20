import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/main.dart';
import 'package:project_june_client/widgets/modal_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class UpdateWidget extends ConsumerWidget {
  final String? releaseNotes;

  const UpdateWidget({Key? key, required this.releaseNotes}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ModalWidget(
      title: '업데이트가 필요해요!',
      description: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          releaseNotes ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorConstants.gray,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ),
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
            child: Text(
              '나중에 할게요',
              style: TextStyle(
                fontSize: 16,
                color: ColorConstants.neutral,
                fontWeight: FontWeightConstants.semiBold,
              ),
              // 모달은 alert로 바꾸면 dark가 안 중요해짐
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          FilledButton(
            onPressed: () {
              launchUrl(Uri.parse(Urls.appstore));
            },
            child: Text(
              '업데이트 하기',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeightConstants.semiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
