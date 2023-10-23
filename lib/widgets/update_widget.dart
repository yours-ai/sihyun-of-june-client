import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/modal_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class UpdateWidget extends StatelessWidget {
  final String isUpdateRequired;

  const UpdateWidget({super.key, required this.isUpdateRequired});

  @override
  Widget build(BuildContext context) {
    return ModalWidget(
      title: '업데이트가 필요해요!',
      description: FutureBuilder(
        future: updateService.getUpdateDescription(),
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(state.data ?? ''),
          );
        },
      ),
      choiceColumn: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isUpdateRequired == 'required')
            const SizedBox.shrink()
          else
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
                style:
                    TextStyle(fontSize: 14.0, color: ColorConstants.secondary),
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
