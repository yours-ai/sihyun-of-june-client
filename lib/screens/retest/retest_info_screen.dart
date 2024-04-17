import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/retest/retest_layout_widget.dart';

import '../../constants.dart';

class RetestInfoScreen extends StatefulWidget {
  final String firstName;

  const RetestInfoScreen(this.firstName, {super.key});

  @override
  State<RetestInfoScreen> createState() => _RetestInfoScreenState();
}

class _RetestInfoScreenState extends State<RetestInfoScreen> {
  bool? canRetest;

  @override
  void initState() {
    super.initState();
    checkCanRetest();
  }

  Future<void> checkCanRetest() async {
    bool tempCanRetest = await characterService.checkCanRetest();
    if (!mounted) return;
    setState(() {
      canRetest = tempCanRetest;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (canRetest == null) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
    return RetestLayoutWidget(
      firstName: widget.firstName,
      title:
          '${widget.firstName}이와의 시간, 즐거우셨나요?\n${canRetest! ? '이제, 새로운 상대를\n만날 수 있어요.' : '조금 더 이어갈 수 있어요.'}',
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
            style: canRetest!
                ? null
                : Theme.of(context).filledButtonTheme.style!.copyWith(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorConstants.lightGray),
                    ),
            onPressed: () {
              if (!canRetest!) {
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
                      .withOpacity(canRetest! ? 1.0 : 0.7)),
            ),
          ),
        ],
      ),
    );
  }
}
