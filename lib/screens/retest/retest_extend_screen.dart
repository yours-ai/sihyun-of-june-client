import 'package:flutter/material.dart';
import 'package:project_june_client/widgets/retest/retest_choice_widget.dart';
import 'package:project_june_client/widgets/retest/retest_layout_widget.dart';

class RetestExtendScreen extends StatelessWidget {
  final String firstName;

  const RetestExtendScreen({super.key, required this.firstName});

  @override
  Widget build(BuildContext context) {
    return RetestLayoutWidget(
        firstName: firstName,
        title: '${firstName}이와의 시간을 늘리려면,\n더 많은 비용이 필요해요.\n그래도 계속하시겠어요?',
        action: const RetestChoiceWidget(
          isExtend: true,
        ));
  }
}
