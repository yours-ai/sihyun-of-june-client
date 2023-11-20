import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/dtos.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/main.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/controllers/auth/name_form_controller.dart';
import 'package:project_june_client/widgets/name_form_widget.dart';

import '../constants.dart';
import '../widgets/modal_widget.dart';

class NameChangeScreen extends ConsumerStatefulWidget {
  const NameChangeScreen({Key? key}) : super(key: key);

  @override
  NameChangeScreenState createState() => NameChangeScreenState();
}

class NameChangeScreenState extends ConsumerState<NameChangeScreen> {
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
          mutation: getNameChangeMutation(
            onSuccess: (res, arg) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('이름이 변경되었습니다.'),
                ),
              );
              context.pop();
              context.go('/all');
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
            description: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                '이름을 바꾸신 다음 날부터 편지에 적용되어요!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorConstants.gray,
                  fontSize: 16,
                  height: 1.5,
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
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(
                    '아니요',
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorConstants.neutral,
                      fontWeight: FontWeightConstants.semiBold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                FilledButton(
                  onPressed: () => mutate(dto),
                  child: Text(
                    '네',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeightConstants.semiBold,
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
                query: getRetrieveMeQuery(),
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
