import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/widgets/common/modal/modal_choice_widget.dart';
import 'package:project_june_client/widgets/common/modal/modal_description_widget.dart';
import 'package:project_june_client/widgets/common/modal/modal_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class UpdateWidget extends ConsumerWidget {
  final String? releaseNotes;

  const UpdateWidget({Key? key, required this.releaseNotes}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ModalWidget(
      title: '업데이트가 필요해요!',
      description: ModalDescriptionWidget(description: releaseNotes ?? ''),
      choiceColumn: ModalChoiceWidget(
        submitText: '업데이트 하기',
        onSubmit: () => launchUrl(Uri.parse(Urls.appstore)),
        cancelText: '나중에 할게요',
        onCancel: () => context.pop(),
      ),
    );
  }
}
