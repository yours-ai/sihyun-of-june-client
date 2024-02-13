import 'dart:async';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/actions/auth/dtos.dart';
import 'package:project_june_client/widgets/common/alert/alert_description_widget.dart';
import 'package:project_june_client/widgets/common/alert/alert_widget.dart';
import 'package:project_june_client/widgets/phone_login/number_input_widget.dart';

import '../common/title_layout.dart';

class PhoneTabWidget extends ConsumerStatefulWidget {
  final void Function(ValidatedAuthCodeDTO dto) onSmsVerify;

  const PhoneTabWidget({Key? key, required this.onSmsVerify}) : super(key: key);

  @override
  PhoneTabWidgetState createState() => PhoneTabWidgetState();
}

class PhoneTabWidgetState extends ConsumerState<PhoneTabWidget> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final authController = TextEditingController();

  ValidatedPhoneDTO? validatedPhoneDTO;
  bool isSubmitted = false;
  int? authCode;

  int seconds = 300;
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        _timer!.cancel();
      }
    });
  }

  void handleSmsSend(ValidatedPhoneDTO dto) {
    showSMSSentDialog();
    isSubmitted == true ? seconds = 300 : startTimer();
    setState(() {
      isSubmitted = true;
      validatedPhoneDTO = dto;
    });
  }

  ValidatedAuthCodeDTO getValidatedData() {
    return ValidatedAuthCodeDTO(
      authCode: authCode!,
      countryCode: validatedPhoneDTO!.countryCode,
      phone: validatedPhoneDTO!.phone,
    );
  }

  Future showSMSSentDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertWidget(
          title: '인증번호 발송',
          content: const AlertDescriptionWidget(description: '인증번호가 발송되었습니다.'),
          confirmText: '확인',
          backgroundColor: ColorConstants.pink,
        );
      },
    );
  }

  String timeFormatter(int seconds) {
    int minutes = seconds ~/ 60;
    int secondsLeft = seconds % 60;
    return '${minutes.toString()}:${secondsLeft.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    authController.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tokenMutation = fetchSmsTokenMutation(
      onSuccess: (res, arg) {
        context.go(RoutePaths.starting);
      },
      onError: (arg, error, fallback) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
          ),
        );
      },
    );
    final mutation = verifySmsCodeMutation(
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
          withAppBar: true,
          title: Text(
            '시작하려면 당신의\n전화번호가 필요해요.',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              NumberInputWidget(
                  onSmsSend: handleSmsSend, isSubmitted: isSubmitted),
              const SizedBox(height: 11),
              isSubmitted == true
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '인증번호를 입력해주세요.';
                          }
                          return null;
                        },
                        controller: authController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  Duration(seconds: seconds)
                                      .toString()
                                      .substring(2, 7),
                                  style: TextStyle(
                                      color: ColorConstants.pink,
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                          contentPadding: const EdgeInsets.only(left: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          hintText: '인증번호 입력',
                          hintStyle: TextStyle(
                              fontSize: 17, color: ColorConstants.neutral),
                        ),
                        style: TextStyle(
                            fontSize: 17,
                            height: 1.2,
                            color: ColorConstants.primary),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          actions: isSubmitted == true
              ? FilledButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorConstants.pink),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      authCode = int.tryParse(authController.text);
                      mutate(getValidatedData());
                    }
                  },
                  child: const Text('다음'))
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
