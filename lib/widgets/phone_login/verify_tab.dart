import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/actions/auth/dtos.dart';

import '../common/title_layout.dart';

class VerifyTabWidget extends StatefulWidget {
  final ValidatedPhoneDTO dto;
  final void Function(ValidatedAuthCodeDTO dto) onSmsVerify;

  const VerifyTabWidget({
    Key? key,
    required this.dto,
    required this.onSmsVerify,
  }) : super(key: key);

  @override
  State<VerifyTabWidget> createState() => _VerifyTabWidgetState();
}

class _VerifyTabWidgetState extends State<VerifyTabWidget> {
  final _formKey = GlobalKey<FormState>();
  final authController = TextEditingController();
  int? authCode;

  ValidatedAuthCodeDTO getValidatedData() {
    return ValidatedAuthCodeDTO(
      authCode: authCode!,
      countryCode: widget.dto.countryCode,
      phone: widget.dto.phone,
    );
  }

  @override
  void dispose() {
    authController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tokenMutation = getSmsTokenMutation(
      onSuccess: (res, arg) {
        context.go('/');
      },
      onError: (arg, error, fallback) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
          ),
        );
      },
    );
    final mutation = getSmsVerifyMutation(
      onSuccess: (res, arg) {
        if (res == true) {
          tokenMutation.mutate(getValidatedData());
        } else {
          widget.onSmsVerify(getValidatedData());
        }
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
          titleText: '인증번호를 입력해주세요.',
          body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '인증번호를 입력해주세요.';
                  }
                  return null;
                },
                controller: authController,
                maxLines: 1,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                minLines: 1,
                decoration: InputDecoration(
                  hintText: '123456',
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
          ]),
          actions: OutlinedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                authCode = int.tryParse(authController.text);
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
