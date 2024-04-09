import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/retest/retest_layout_widget.dart';

import '../../constants.dart';

class RetestInfoScreen extends StatefulWidget {
  final String firstName;
  final List<int> characterIds;

  const RetestInfoScreen({
    super.key,
    required this.firstName,
    required this.characterIds,
  });

  @override
  State<RetestInfoScreen> createState() => _RetestInfoScreenState();
}

class _RetestInfoScreenState extends State<RetestInfoScreen> {
  late bool isEnableToRetest;

  @override
  void initState() async {
    super.initState();
    isEnableToRetest = await characterService.checkEnableToRetest();
  }

  @override
  Widget build(BuildContext context) {
    return RetestLayoutWidget(
      firstName: widget.firstName,
      title:
          '${widget.firstName}이와의 시간, 즐거우셨나요?\n${isEnableToRetest ? '이제, 새로운 상대를\n만날 수 있어요.' : '조금 더 이어갈 수 있어요.'}',
      action: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FilledButton(
            style: Theme.of(context).filledButtonTheme.style!.copyWith(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(ColorConstants.gray),
                ),
            onPressed: () {
              context.push(
                RoutePaths.retestExtend,
                extra: widget.firstName,
              );
            },
            child: Text('${widget.firstName}이와의 시간 이어가기'),
          ),
          const SizedBox(
            height: 13,
          ),
          FilledButton(
            style: isEnableToRetest
                ? null
                : Theme.of(context).filledButtonTheme.style!.copyWith(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorConstants.lightGray),
                    ),
            onPressed: () {
              if (!isEnableToRetest) {
                return;
              }
              context.push(
                RoutePaths.retestConfirm,
                extra: widget.firstName,
              );
            },
            child: Text(
              '새로운 상대 만나기',
              style: TextStyle(
                  color: ColorConstants.background
                      .withOpacity(isEnableToRetest ? 1.0 : 0.7)),
            ),
          ),
        ],
      ),
    );
  }
}
