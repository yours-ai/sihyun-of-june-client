import 'package:flutter/material.dart';
import 'package:project_june_client/actions/auth/dtos.dart';

class NameFormController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  String? validator(bool isLastNameEmpty, bool isFirstNameEmpty) {
    if (isLastNameEmpty && isFirstNameEmpty) {
      return '성과 이름을 입력해주세요.';
    } else if (isLastNameEmpty) {
      return '성을 입력해주세요.';
    } else if (isFirstNameEmpty) {
      return '이름을 입력해주세요.';
    }
    return null;
  }

  bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  UserNameDTO getFormData() {
    return UserNameDTO(
        firstName: firstNameController.text, lastName: lastNameController.text);
  }

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
  }
}
