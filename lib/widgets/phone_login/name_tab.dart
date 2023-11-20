import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/dtos.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/controllers/auth/name_form_controller.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/name_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../actions/analytics/queries.dart';
import '../../main.dart';
import '../modal_widget.dart';

class NameTabWidget extends ConsumerStatefulWidget {
  final ValidatedAuthCodeDTO dto;

  const NameTabWidget({Key? key, required this.dto}) : super(key: key);

  @override
  NameTabWidgetState createState() => NameTabWidgetState();
}

class NameTabWidgetState extends ConsumerState<NameTabWidget> {
  final NameFormController formController = NameFormController();

  ValidatedUserDTO getValidatedData() {
    return ValidatedUserDTO(
      phone: widget.dto.phone,
      countryCode: widget.dto.countryCode,
      authCode: widget.dto.authCode,
      firstName: formController.firstNameController.text,
      lastName: formController.lastNameController.text,
    );
  }

  void _showSignInModal(ValidatedUserDTO dto, String? funnel) async {
    await showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return MutationBuilder(
          mutation: getSmsTokenMutation(
            onSuccess: (res, arg) {
              getUserFunnelMutation(onSuccess: (res, arg) {
                context.go('/');
              }).mutate(funnel);
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
    formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? funnel = ref.watch(deepLinkProvider.notifier).state?.mediaSource;
    return TitleLayout(
      titleText: '이름을 알려주세요.',
      body: Form(
          child: NameFormWidget(
        formController: formController,
      )),
      actions: OutlinedButton(
        onPressed: () {
          if (formController.validate()) {
            _showSignInModal(getValidatedData(), funnel);
          }
        },
        style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(16.0)),
        child: const Text('다음'),
      ),
    );
  }
}
