import 'package:flutter/material.dart';
import 'package:project_june_client/actions/auth/dtos.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/phone_login/name_tab.dart';
import 'package:project_june_client/widgets/phone_login/verify_tab.dart';
import 'package:project_june_client/widgets/phone_login/phone_tab.dart';


class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State createState() => _PhoneLoginScreen();
}

class _PhoneLoginScreen extends State<PhoneLoginScreen> {
  int _tab = 0;
  ValidatedPhoneDTO? validatedPhoneDTO;
  ValidatedAuthCodeDTO? validatedAuthDTO;

  void handleSmsSend(ValidatedPhoneDTO dto) {
    setState(() {
      validatedPhoneDTO = dto;
      _tab = 1;
    });
  }

  void handleVerify(ValidatedAuthCodeDTO dto) {
    setState(() {
      validatedAuthDTO = dto;
      _tab = 2;
    });
  }

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: _tab == 0
              ? PhoneTabWidget(
                  onSmsSend: handleSmsSend,
                )
              : _tab == 1
                  ? VerifyTabWidget(
                      dto: validatedPhoneDTO!,
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
