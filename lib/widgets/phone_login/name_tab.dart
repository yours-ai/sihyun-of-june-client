import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/dtos.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/controllers/auth/name_form_controller.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/name_form_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../modal_widget.dart';

class NameTabWidget extends StatefulWidget {
  final ValidatedAuthCodeDTO dto;

  const NameTabWidget({Key? key, required this.dto}) : super(key: key);

  @override
  State<NameTabWidget> createState() => _NameTabWidgetState();
}

class _NameTabWidgetState extends State<NameTabWidget> {
  final NameFormController formController = NameFormController();
  bool isSubmitClicked = false;
  bool isValid = false;

  void handleError(bool hasError) {
    setState(() {
      isValid = !hasError;
    });
  }

  ValidatedUserDTO getValidatedData() {
    return ValidatedUserDTO(
      phone: widget.dto.phone,
      countryCode: widget.dto.countryCode,
      authCode: widget.dto.authCode,
      firstName: formController.firstNameController.text,
      lastName: formController.lastNameController.text,
    );
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
                OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorConstants.background),
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(
                    '취소하기',
                    style: TextStyle(
                        fontSize: 16.0, color: ColorConstants.neutral),
                  ),
                ),
                const SizedBox(height: 8.0),
                FilledButton(
                  onPressed: () => mutate(dto),
                  child: const Text(
                    '동의하고 시작하기',
                    style: TextStyle(
                      fontSize: 16.0,
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
    formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TitleLayout(
      withAppBar: true,
      title: Text(
        '이름을 알려주세요.',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NameFormWidget(
            formController: formController,
            isSubmitClicked: isSubmitClicked,
            onError: handleError,
          ),
        ],
      ),
      actions: FilledButton(
        onPressed: () {
          setState(() {
            isSubmitClicked = true;
          });
          if (isValid) {
            _showSignInModal(getValidatedData());
          }
        },
        style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(16.0)),
        child: const Text('다음'),
      ),
    );
  }
}
