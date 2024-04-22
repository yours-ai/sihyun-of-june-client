import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/dtos.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/modal/modal_description_widget.dart';
import 'package:project_june_client/widgets/common/modal/modal_widget.dart';
import 'package:project_june_client/widgets/phone_login/name_tab.dart';
import 'package:project_june_client/widgets/phone_login/phone_tab.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State createState() => _PhoneLoginScreen();
}

class _PhoneLoginScreen extends State<PhoneLoginScreen> {
  int _tab = 1;
  ValidatedPhoneDTO? validatedPhoneDTO;
  ValidatedAuthCodeDTO? validatedAuthDTO;

  void handleVerify(ValidatedAuthCodeDTO dto) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ModalWidget(
          title: '서비스 종료 예정으로\n더 이상 가입할 수 없어요.',
          choiceColumn: FilledButton(
            onPressed: () => context.pop(),
            child: const Text('알겠어요'),
          ),
        );
      },
    );
  }

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 20, top: 30),
            child: Text(
              '$_tab/2',
              style: TextStyle(color: ColorConstants.neutral, fontSize: 20),
            ),
          ),
          backgroundColor: ColorConstants.background,
          elevation: 0,
        ),
        body: SafeArea(
          child: _tab == 1
              ? PhoneTabWidget(
                  onSmsVerify: handleVerify,
                )
              : _tab == 2
                  ? NameTabWidget(
                      dto: validatedAuthDTO!,
                    )
                  : Container(),
        ),
      ),
    );
  }
}
