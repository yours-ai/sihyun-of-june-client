import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/dtos.dart';
import 'package:project_june_client/widgets/withdraw/guide_tab.dart';
import 'package:project_june_client/widgets/withdraw/reason_tab.dart';

import '../widgets/modal_widget.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  int _tab = 0;

  void handleQuitResponse() {
    setState(() {
      _tab = 1;
    });
  }

  void _showWithdrawModal() async {
    await showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) {
        return ModalWidget(
            title: '탈퇴가 완료되었어요.',
            description: const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text('유월의 시현이에 관심 가져주셔서 감사했어요.'),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _tab == 0
            ? ReasonTabWidget(
                onQuitResponse: handleQuitResponse,
              )
            : _tab == 1
                ? GuideTabWidget(onWithdraw: _showWithdrawModal)
                : Container(),
      ),
    );
  }
}
