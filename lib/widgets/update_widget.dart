import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/modal_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class UpdateWidget extends StatelessWidget {
  final String? releaseNotes;

  const UpdateWidget({Key? key, required this.releaseNotes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModalWidget(
      title: '업데이트가 필요해요!',
      description: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(releaseNotes ?? ''),
      ),
      choiceColumn: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FilledButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(ColorConstants.background),
            ),
            onPressed: () {
              context.pop();
            },
            child: Text(
              '나중에 할게요.',
              style: TextStyle(fontSize: 14.0, color: ColorConstants.secondary),
            ),
          ),
          FilledButton(
            onPressed: () {
              launchUrl(Uri.parse(Urls.appstore));
            },
            child: const Text(
              '업데이트 하기',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }
}
