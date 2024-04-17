import 'package:flutter/material.dart';
import 'package:project_june_client/controllers/auth/name_form_controller.dart';
import '../constants.dart';

class NameFormWidget extends StatefulWidget {
  String initialFirstName;
  String initialLastName;
  final NameFormController formController;
  bool isSubmitClicked;
  bool shouldHandleNameController;
  final Function(bool) onError;

  NameFormWidget(
      {Key? key,
      this.initialFirstName = '',
      this.initialLastName = '',
      required this.formController,
      this.shouldHandleNameController = false,
      required this.isSubmitClicked,
      required this.onError})
      : super(key: key);

  @override
  State<NameFormWidget> createState() => _NameFormWidgetState();
}

class _NameFormWidgetState extends State<NameFormWidget> {
  String errorMessage = '';
  var firstNameFieldColor = ColorConstants.neutral;
  var lastNameFieldColor = ColorConstants.neutral;

  void setNameControllerText() {
    if (widget.shouldHandleNameController) {
      widget.formController.firstNameController.text = widget.initialFirstName;
      widget.formController.lastNameController.text = widget.initialLastName;
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.shouldHandleNameController == true) {
      setNameControllerText();
    }
  }

  void changeBorderColor() {
    if (widget.isSubmitClicked == true) {
      setState(() {
        firstNameFieldColor =
            widget.formController.firstNameController.text.isEmpty
                ? Colors.red
                : ColorConstants.neutral;
        lastNameFieldColor =
            widget.formController.lastNameController.text.isEmpty
                ? Colors.red
                : ColorConstants.neutral;
      });
    }
  }

  void validate(String? value, TextEditingController controller) {
    bool isLastNameEmpty =
        widget.formController.lastNameController.text.isEmpty;
    bool isFirstNameEmpty =
        widget.formController.firstNameController.text.isEmpty;

    String? error =
        widget.formController.validator(isLastNameEmpty, isFirstNameEmpty);
    if (error != null) {
      setState(() {
        errorMessage = error;
        widget.onError(true);
        changeBorderColor();
      });
    } else {
      setState(() {
        errorMessage = '';
        widget.onError(false);
        changeBorderColor();
      });
    }
    return;
  }

  InputDecoration getDecoration(String hintText, Color borderColor) {
    return InputDecoration(
      contentPadding: const EdgeInsets.only(left: 10),
      errorStyle: const TextStyle(fontSize: 0, height: 0),
      hintText: hintText,
      hintStyle: TextStyle(fontSize: 17, color: ColorConstants.neutral),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: BorderSide(
          width: 1.0,
          color: borderColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: BorderSide(
          width: 1.0,
          color: borderColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: widget.formController.lastNameController,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  validate(value, widget.formController.lastNameController);
                },
                decoration: getDecoration('홍', lastNameFieldColor),
                style: TextStyle(
                  color: ColorConstants.primary,
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: widget.formController.firstNameController,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  validate(value, widget.formController.lastNameController);
                },
                decoration: getDecoration('길동', firstNameFieldColor),
                style: TextStyle(
                  color: ColorConstants.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              widget.isSubmitClicked == true ? errorMessage : '',
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 10, color: Colors.red),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '※ 지금 입력해주신 이름으로 매일 밤 편지를 보내드려요 :)',
            style: TextStyle(
                color: ColorConstants.neutral,
                fontSize: 13,
                fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }
}
