import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/dtos.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/controllers/auth/name_form_controller.dart';
import 'package:project_june_client/providers/one_link_provider.dart';
import 'package:project_june_client/widgets/common/modal/modal_choice_widget.dart';
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
          mutation: fetchSmsTokenMutation(
            onSuccess: (res, arg) async {
              await sendUserFunnelMutation()
                  .mutate(funnelDTO)
                  .then((_) => context.go(RoutePaths.starting));
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
            choiceColumn: ModalChoiceWidget(
              isDefaultButton: true,
              cancelText: '취소하기',
              submitText: '동의하고 시작하기',
              onCancel: () async => context.pop(),
              onSubmit: () => mutate(dto),
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
        funnel: ref.watch(oneLinkProvider)?['media_source'] ??
            ref.watch(deepLinkProvider)?.mediaSource?.toString(),
        refCode: ref.watch(oneLinkProvider)?['af_sub1'] ??
            ref.watch(deepLinkProvider)?.afSub1?.toString());
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
          backgroundColor: MaterialStateProperty.all(ColorConstants.pink),
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
