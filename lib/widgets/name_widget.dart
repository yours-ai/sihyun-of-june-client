import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/dtos.dart';
import 'package:project_june_client/controllers/auth/name_form_controller.dart';
import 'package:project_june_client/widgets/phone_login/name_tab.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import 'common/title_layout.dart';
import 'modal_widget.dart';

class NameFormWidget extends StatefulWidget {
  String initialFirstName;
  String initialLastName;
  final NameFormController formController;
  bool shouldHandleNameController;

  NameFormWidget(
      {Key? key,
      this.initialFirstName = '',
      this.initialLastName = '',
      required this.formController,
      this.shouldHandleNameController = false})
      : super(key: key);

  @override
  State<NameFormWidget> createState() => _NameFormWidgetState();
}

class _NameFormWidgetState extends State<NameFormWidget> {
  String errorMessage = '';

  void setNameControllerText() {
    if (widget.shouldHandleNameController) {
      widget.formController.firstNameController.text = widget.initialFirstName;
      widget.formController.lastNameController.text = widget.initialLastName;
    }
  }

  @override
  void initState() {
    setNameControllerText();
    super.initState();
  }

  String? _validator(String? value, TextEditingController controller) {
    bool isLastNameEmpty =
        widget.formController.lastNameController.text.isEmpty;
    bool isFirstNameEmpty =
        widget.formController.firstNameController.text.isEmpty;

    String? error =
        widget.formController.validator(isLastNameEmpty, isFirstNameEmpty);
    if (error != null) {
      setState(() {
        errorMessage = error;
      });
      return error;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formController.formKey,
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
                    validator: (value) => _validator(
                        value, widget.formController.lastNameController),
                    controller: widget.formController.lastNameController,
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
                    ),
                    style: TextStyle(
                        fontFamily: 'MaruBuri',
                        fontSize: 25,
                        color: ColorConstants.primary),
                  ),
                ),
                const SizedBox(width: 15),
                IntrinsicWidth(
                  child: TextFormField(
                    validator: (value) => _validator(
                        value, widget.formController.firstNameController),
                    controller: widget.formController.firstNameController,
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
