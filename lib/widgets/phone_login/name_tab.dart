import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/dtos.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/controllers/auth/name_form_controller.dart';
import 'package:project_june_client/providers/deep_link_provider.dart';
import 'package:project_june_client/widgets/common/modal/modal_widget.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/common/modal/modal_description_widget.dart';
import 'package:project_june_client/widgets/name_form_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../actions/analytics/dtos.dart';
import '../../actions/analytics/queries.dart';

class NameTabWidget extends ConsumerStatefulWidget {
  final ValidatedAuthCodeDTO dto;

  const NameTabWidget({Key? key, required this.dto}) : super(key: key);

  @override
  NameTabWidgetState createState() => NameTabWidgetState();
}

class NameTabWidgetState extends ConsumerState<NameTabWidget> {
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

  void _showSignInModal(ValidatedUserDTO dto, UserFunnelDTO funnelDTO) async {
    await showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return MutationBuilder(
          mutation: getSmsTokenMutation(
            onSuccess: (res, arg) {
              getUserFunnelMutation(onSuccess: (res, arg) {
                context.go('/');
              }).mutate(funnelDTO);
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
            description: ModalDescriptionWidget(
              descriptionWidget: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodySmall,
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
                  ],
                ),
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
                  onPressed: () => context.pop(),
                  child: Text(
                    '취소하기',
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorConstants.gray,
                      fontWeight: FontWeightConstants.semiBold,
                      height: 1.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                FilledButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorConstants.pink),
                  ),
                  onPressed: () => mutate(dto),
                  child: Text(
                    '동의하고 시작하기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeightConstants.semiBold,
                      height: 1.0,
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
    UserFunnelDTO funnelDTO = UserFunnelDTO(
        funnel: ref.watch(deepLinkProvider.notifier).state?.mediaSource,
        refCode: ref.watch(deepLinkProvider.notifier).state?.afSub1);
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
        style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all(ColorConstants.pink),
        ),
        onPressed: () {
          setState(() {
            isSubmitClicked = true;
          });
          if (isValid) {
            _showSignInModal(getValidatedData(), funnelDTO);
          }
        },
        child: const Text('다음'),
      ),
    );
  }
}
