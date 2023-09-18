import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/dtos.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:url_launcher/url_launcher.dart';

import '../modal_widget.dart';

class NameTabWidget extends StatefulWidget {
  final ValidatedAuthCodeDTO dto;

  const NameTabWidget({Key? key, required this.dto}) : super(key: key);

  @override
  State<NameTabWidget> createState() => _NameTabWidgetState();
}

class _NameTabWidgetState extends State<NameTabWidget> {
  final _formKey = GlobalKey<FormState>();
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  String errorMessage = '';

  ValidatedUserDTO getValidatedData() {
    return ValidatedUserDTO(
      phone: widget.dto.phone,
      countryCode: widget.dto.countryCode,
      authCode: widget.dto.authCode,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
    );
  }

  String? _validator(String? value, TextEditingController controller) {
    bool isLastNameEmpty = lastNameController.text.isEmpty;
    bool isFirstNameEmpty = firstNameController.text.isEmpty;

    if (isLastNameEmpty && isFirstNameEmpty) {
      setState(() {
        errorMessage = '성과 이름을 입력해주세요.';
      });
      return '성과 이름을 입력해주세요.';
    } else if (isLastNameEmpty) {
      setState(() {
        errorMessage = '성을 입력해주세요.';
      });
      return '성을 입력해주세요.';
    } else if (isFirstNameEmpty) {
      setState(() {
        errorMessage = '이름을 입력해주세요.';
      });
      return '이름을 입력해주세요.';
    }
    return null;
  }

  void _showSignInModal(ValidatedUserDTO dto) async {
    await showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return MutationBuilder(
          mutation: getSmsTokenMutation(
            onSuccess: (res, arg) {
              context.go('/');
            },
            onError: (arg, error, fallback) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error.toString()),
                ),
              );
            },
          ),
          builder: (context, state, mutate) => ModalWidget(
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
                  onPressed: () => mutate(dto),
                  child: const Text(
                    '동의하고 시작하기',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TitleLayout(
        titleText: '이름을 알려주세요.',
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IntrinsicWidth(
                    child: TextFormField(
                      validator: (value) =>
                          _validator(value, lastNameController),
                      controller: lastNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),
                        errorStyle: const TextStyle(
                          fontSize: 0,
                        ),
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
                      validator: (value) =>
                          _validator(value, firstNameController),
                      controller: firstNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),
                        errorStyle: const TextStyle(
                          fontSize: 0,
                        ),
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
              const SizedBox(height: 8),
              Text(errorMessage,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontFamily: 'MaruBuri', fontSize: 12, color: Colors.red)),
            ],
          ),
        ),
        actions: OutlinedButton(
          onPressed: () {
            if (_formKey.currentState != null &&
                _formKey.currentState!.validate()) {
              _showSignInModal(getValidatedData());
            }
          },
          style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(16.0)),
          child: const Text('다음'),
        ),
      ),
    );
  }
}
