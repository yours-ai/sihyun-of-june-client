import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/dtos.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import 'package:project_june_client/widgets/common/modal/modal_widget.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/controllers/auth/name_form_controller.dart';
import 'package:project_june_client/widgets/common/modal/modal_choice_widget.dart';
import 'package:project_june_client/widgets/common/modal/modal_description_widget.dart';
import 'package:project_june_client/widgets/name_form_widget.dart';

class ChangeNameScreen extends ConsumerStatefulWidget {
  const ChangeNameScreen({Key? key}) : super(key: key);

  @override
  ChangeNameScreenState createState() => ChangeNameScreenState();
}

class ChangeNameScreenState extends ConsumerState<ChangeNameScreen> {
  final NameFormController formController = NameFormController();
  bool isSubmitClicked = false;
  bool isValid = true;

  void handleError(bool hasError) {
    setState(() {
      isValid = !hasError;
    });
  }

  void nameChangeModal(UserNameDTO dto) async {
    await showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return MutationBuilder(
          mutation: changeNameMutation(
            onSuccess: (res, arg) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('이름이 변경되었습니다.'),
                ),
              );
              context.pop();
              context.go(RoutePaths.all);
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
            title: '이렇게 불러드릴까요?',
            description: const ModalDescriptionWidget(
                description: '이름을 바꾸신 다음 날부터 편지에 적용되어요!'),
            choiceColumn: ModalChoiceWidget(
              submitText: '네',
              onSubmit: () => mutate(dto),
              cancelText: '아니요',
              onCancel: () async => context.pop(),
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const BackAppbar(),
        body: SafeArea(
          child: TitleLayout(
              withAppBar: true,
              title: Text(
                '어떻게\n불러드릴까요?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              body: QueryBuilder(
                query: fetchMeQuery(),
                builder: (context, state) {
                  return state.data == null
                      ? const SizedBox.shrink()
                      : NameFormWidget(
                          initialFirstName: state.data!.first_name,
                          initialLastName: state.data!.last_name,
                          formController: formController,
                          shouldHandleNameController: true,
                          isSubmitClicked: isSubmitClicked,
                          onError: handleError,
                        );
                },
              ),
              actions: FilledButton(
                onPressed: () {
                  setState(() {
                    isSubmitClicked = true;
                  });
                  if (isValid) {
                    nameChangeModal(formController.getFormData());
                  }
                },
                child: const Text(
                  '변경하기',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
