import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/dtos.dart';
import 'package:project_june_client/widgets/modal/modal_description_widget.dart';
import 'package:project_june_client/widgets/withdraw/guide_tab.dart';
import 'package:project_june_client/widgets/withdraw/reason_tab.dart';

import '../constants.dart';
import '../widgets/modal/modal_widget.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  int _tab = 0;
  QuitReasonDTO reasonDTO = QuitReasonDTO();

  final reasonController = TextEditingController();

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  void handleQuitResponse(QuitReasonDTO dto) {
    setState(() {
      reasonDTO = dto;
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
        return const ModalWidget(
          title: '탈퇴가 완료되었어요.',
          description:
              ModalDescriptionWidget(description: '유월의 시현이에 관심 가져주셔서 감사했어요.'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.background,
          elevation: 0,
          leading: IconButton(
            onPressed: _tab == 0
                ? () => context.pop()
                : () => setState(() {
                      _tab = 0;
                    }),
            icon: Container(
              padding: const EdgeInsets.only(left: 23),
              child: Icon(
                PhosphorIcons.arrow_left,
                color: ColorConstants.gray,
                size: 32,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: _tab == 0
              ? ReasonTabWidget(
                  onQuitResponse: handleQuitResponse,
                  dto: reasonDTO,
                  reasonController: reasonController,
                )
              : _tab == 1
                  ? GuideTabWidget(
                      onWithdraw: _showWithdrawModal,
                      dto: reasonDTO,
                    )
                  : Container(),
        ),
      ),
    );
  }
}
