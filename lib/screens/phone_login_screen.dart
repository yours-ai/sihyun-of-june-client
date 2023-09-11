import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/actions.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/modal_widget.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController phoneController = TextEditingController();
final TextEditingController authController = TextEditingController();
final TextEditingController lastNameController = TextEditingController();
final TextEditingController firstNameController = TextEditingController();
Map<String, dynamic> _formData = {};

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State createState() => _PhoneLoginScreen();
}

class ToLoginData {
  final String title;
  final Widget body;

  const ToLoginData({required this.title, required this.body});
}

List<ToLoginData> tabList = [
  ToLoginData(
    title: '시작하려면\n전화번호가 필요해요.',
    body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Row(children: [
          Text(
            '+82',
            style: TextStyle(
                fontFamily: 'MaruBuri',
                fontSize: 25,
                color: ColorConstants.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              key: _formKey,
              controller: phoneController,
              maxLines: 1,
              keyboardType: TextInputType.number,
              minLines: 1,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly, // Only integers allowed
              ],
              decoration: InputDecoration(
                hintText: '01012345678',
                hintStyle: TextStyle(
                    fontFamily: 'MaruBuri',
                    fontSize: 25,
                    color: ColorConstants.neutral),
                border: InputBorder.none,
              ),
              style: TextStyle(
                  fontFamily: 'MaruBuri',
                  fontSize: 25,
                  color: ColorConstants.primary),
            ),
          ),
        ]),
      ),
    ]),
  ),
  ToLoginData(
    title: '인증번호를 입력해주세요.',
    body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: TextField(
          controller: authController,
          maxLines: 1,
          keyboardType: TextInputType.number,
          minLines: 1,
          decoration: InputDecoration(
            hintText: '123456',
            hintStyle: TextStyle(
                fontFamily: 'MaruBuri',
                fontSize: 25,
                color: ColorConstants.neutral),
            border: InputBorder.none,
          ),
          style: TextStyle(
              fontFamily: 'MaruBuri',
              fontSize: 25,
              color: ColorConstants.primary),
        ),
      ),
    ]),
  ),
  ToLoginData(
    title: '이름을 알려주세요.',
    body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IntrinsicWidth(
              child: TextFormField(
                controller: lastNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: '성',
                  hintStyle: TextStyle(
                      fontFamily: 'MaruBuri',
                      fontSize: 25,
                      color: ColorConstants.neutral),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                    fontFamily: 'MaruBuri',
                    fontSize: 25,
                    color: ColorConstants.primary),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: TextFormField(
                controller: firstNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: '이름',
                  hintStyle: TextStyle(
                      fontFamily: 'MaruBuri',
                      fontSize: 25,
                      color: ColorConstants.neutral),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                    fontFamily: 'MaruBuri',
                    fontSize: 25,
                    color: ColorConstants.primary),
              ),
            ),
          ],
        ),
      ),
    ]),
  ),
];

class _PhoneLoginScreen extends State<PhoneLoginScreen> {
  int _tab = 0;
  String token = '';

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
                          ..onTap = () => launchUrl(Uri.parse(
                                    'https://pygmalion.app/policy/terms'))
                              ),
                    const TextSpan(text: ' 및 '),
                    TextSpan(
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                        text: '개인정보처리방침',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => launchUrl(Uri.parse(
                                    'https://pygmalion.app/policy/privacy'))
                              ),
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
                  context.go('/landing');
                },
                child: Text(
                  '취소',
                  style: TextStyle(
                      fontSize: 14.0, color: ColorConstants.secondary),
                ),
              ),
              FilledButton(
                onPressed: () => context.go('/all'),
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

  void _changeTab() async {
    switch (_tab) {
      case 0:
        int? phoneNumber = int.tryParse(phoneController.text);

        if (phoneController.text.length != 11 || phoneNumber == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                '올바른 전화번호를 입력해주세요.',
              ),
            ),
          );
        }

        _formData['phone'] = phoneNumber;


        String? result;
        try {
          result = await smsSend(_formData['phone']);
        } catch (error) {
        }

        setState(() {
          if (result == 'success') {
            _tab++;
          }
        });
        break;
      case 1:
        int? authNumber = int.tryParse(authController.text);
        _formData['auth_code'] = authNumber;

        String result;
        try {
          result = await smsVerify(_formData['phone'], _formData['auth_code']);
        } catch (error) {
          result = 'error'; // 또는 적절한 에러 메시지
        }

        setState(() {
          if (result == 'success') {
            _tab++;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  '인증번호가 일치하지 않습니다.',
                ),
              ),
            );
            _tab = 1;
          }
        });
        break;
      case 2:
        setState(() {
          _formData['last_name'] = lastNameController.text;
          _formData['first_name'] = firstNameController.text;
          getServerTokenBySMS(_formData['phone'], _formData['last_name'],
              _formData['first_name']);
        });
        if (token != '') {
          saveServerToken(token);
          _showModal();
        }
        break;
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: SafeArea(
        child: TitleLayout(
          titleText: tabList[_tab].title,
          body: tabList[_tab].body,
          actions: OutlinedButton(
            onPressed: _changeTab,
            child: const Text('다음'),
          ),
        ),
      ),
    );
  }
}
