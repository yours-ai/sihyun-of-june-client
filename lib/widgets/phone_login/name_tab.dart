import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:project_june_client/actions/auth/dtos.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';

class NameTabWidget extends StatefulWidget {
  final void Function(ValidatedUserDTO dto) onSmsLogin;
  final ValidatedAuthCodeDTO dto;

  const NameTabWidget({Key? key, required this.onSmsLogin, required this.dto})
      : super(key: key);

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

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mutation = getSmsTokenMutation(
      onSuccess: (res, arg) {
        widget.onSmsLogin(getValidatedData());
      },
      onError: (arg, error, fallback) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
          ),
        );
      },
    );

    return MutationBuilder(
      mutation: mutation,
      builder: (context, state, mutate) => Form(
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
                          errorStyle: TextStyle(
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
                          errorStyle: TextStyle(
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
                SizedBox(height: 8),
                Text(errorMessage,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'MaruBuri',
                        fontSize: 12,
                        color: Colors.red)),
              ],
            ),
          ),
          actions: OutlinedButton(
            onPressed: () {
              if (_formKey.currentState != null &&
                  _formKey.currentState!.validate()) {
                mutate(getValidatedData());
              }
            },
            child: const Text('다음'),
            style:
                OutlinedButton.styleFrom(padding: const EdgeInsets.all(16.0)),
          ),
        ),
      ),
    );
  }
}
