import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/dtos.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/phone_login/name_tab.dart';
import 'package:project_june_client/widgets/phone_login/verify_tab.dart';
import 'package:project_june_client/widgets/phone_login/phone_tab.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/modal_widget.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State createState() => _PhoneLoginScreen();
}

class _PhoneLoginScreen extends State<PhoneLoginScreen> {
  int _tab = 0;
  ValidatedPhoneDTO? validatedPhoneDTO;
  ValidatedAuthCodeDTO? validatedAuthDTO;

  void _showModal() async {
    await showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return ModalWidget(
          title: '시작하려면 동의해주세요',
          description: Padding(
            padding: const EdgeInsets.only(top: 26),
            child: RichText(
              text: TextSpan(
                  style: TextStyle(
                      fontFamily: 'MaruBuri',
                      fontSize: 15,
                      color: ColorConstants.black),
                  children: [
                    TextSpan(
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                        text: '이용약관',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => launchUrl(Uri.parse(Urls.terms))),
                    const TextSpan(text: ' 및 '),
                    TextSpan(
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                        text: '개인정보처리방침',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => launchUrl(Uri.parse(Urls.privacy))),
                    const TextSpan(text: '에 동의해야 시작할 수 있어요.'),
                  ]),
            ),
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
                  '취소',
                  style: TextStyle(
                      fontSize: 14.0, color: ColorConstants.secondary),
                ),
              ),
              FilledButton(
                onPressed: () => context.go('/'),
                child: const Text(
                  '동의하고 시작하기',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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

  void handleSmsLogin(dynamic dto) {
    setState(() {
      context.go('/');
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: SafeArea(
        child: _tab == 0
            ? PhoneTabWidget(
                onSmsSend: handleSmsSend,
              )
            : _tab == 1
                ? VerifyTabWidget(
                    dto: this.validatedPhoneDTO!,
                    onSmsVerify: handleVerify,
                    onSmsLogin: handleSmsLogin,
                  )
                : _tab == 2
                    ? NameTabWidget(
                        dto: this.validatedAuthDTO!,
                        onSmsLogin: handleSmsLogin,
                      )
                    : Container(),
      ),
    );
  }
}
