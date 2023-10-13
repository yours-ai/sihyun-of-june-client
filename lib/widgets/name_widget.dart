import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/dtos.dart';
import 'package:project_june_client/widgets/phone_login/name_tab.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import 'common/title_layout.dart';
import 'modal_widget.dart';

class NameFormWidget extends StatefulWidget {
  final Widget confirmModal;

  const NameFormWidget({Key? key, required this.confirmModal})
      : super(key: key);

  @override
  State<NameFormWidget> createState() => _NameFormWidgetState();
}

class _NameFormWidgetState extends State<NameFormWidget> {
  final _formKey = GlobalKey<FormState>();

  final lastNameController = TextEditingController();

  final firstNameController = TextEditingController();

  String errorMessage = '';

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
    return Form(
      key: _formKey,
      child: Padding(
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
                    validator: (value) => _validator(value, lastNameController),
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
    );
  }
}
