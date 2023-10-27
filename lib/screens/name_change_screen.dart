import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/dtos.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/controllers/auth/name_form_controller.dart';
import 'package:project_june_client/widgets/name_widget.dart';

import '../constants.dart';
import '../widgets/modal_widget.dart';

class NameChangeScreen extends StatefulWidget {
  NameChangeScreen({Key? key}) : super(key: key);

  @override
  State<NameChangeScreen> createState() => _NameChangeScreenState();
}

class _NameChangeScreenState extends State<NameChangeScreen> {
  final NameFormController formController = NameFormController();

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
            description: const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text('이름을 바꾸신 다음 날부터 편지에 적용되어요!'),
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
                    '아니요',
                    style: TextStyle(
                        fontSize: 14.0, color: ColorConstants.secondary),
                  ),
                ),
                FilledButton(
                  onPressed: () => mutate(dto),
                  child: const Text(
                    '네',
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.background,
          elevation: 0,
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: Container(
              padding: const EdgeInsets.only(left: 23),
              child: Icon(
                PhosphorIcons.arrow_left,
                color: ColorConstants.black,
                size: 32,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: TitleLayout(
              withAppBar: true,
              titleText: "어떻게\n불러드릴까요?",
              body: QueryBuilder(
                query: getRetrieveMeQuery(),
                builder: (context, state) {
                  return state.data == null
                      ? const SizedBox.shrink()
                      : Form(
                          child: NameFormWidget(
                            initialFirstName: state.data!.first_name,
                            initialLastName: state.data!.last_name,
                            formController: formController,
                            shouldHandleNameController: true,
                          ),
                        );
                },
              ),
              actions: FilledButton(
                onPressed: () {
                  if (formController.validate()) {
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
