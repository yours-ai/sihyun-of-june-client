import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/actions/auth/dtos.dart';

class NumberInputWidget extends StatefulWidget {
  final void Function(ValidatedPhoneDTO dto) onSmsSend;
  final bool isSubmitted;

  const NumberInputWidget(
      {Key? key, required this.onSmsSend, required this.isSubmitted})
      : super(key: key);

  @override
  State<NumberInputWidget> createState() => _NumberInputWidgetState();
}

class _NumberInputWidgetState extends State<NumberInputWidget> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  ValidatedPhoneDTO getValidatedData() {
    return ValidatedPhoneDTO(
      phone: phoneController.text,
      countryCode: '82',
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mutation = sendSmsVerificationMutation(
      onSuccess: (res, arg) {
        widget.onSmsSend(getValidatedData());
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      enabled: widget.isSubmitted == false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '전화번호를 입력해주세요.';
                        }
                        if (value.length != 11) {
                          return '올바른 전화번호를 입력해주세요.';
                        }
                        return null;
                      },
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 10.0),
                        hintText: "휴대폰 번호 입력('-' 제외)",
                        hintStyle: TextStyle(
                          color: ColorConstants.neutral,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: BorderSide(
                            color: ColorConstants.neutral,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: BorderSide(
                            color: ColorConstants.neutral,
                          ),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 17,
                        height: 1.2,
                        color: widget.isSubmitted ? ColorConstants.neutral : ColorConstants.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  widget.isSubmitted == false
                      ? FilledButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(ColorConstants.pink),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                            ),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                vertical: 14.0,
                                horizontal: 20.0,
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              mutate(getValidatedData().phone);
                            }
                          },
                          child: const Text('인증요청',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.normal)),
                        )
                      : TextButton(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: ColorConstants.gray,
                                  width: 1.0,
                                ),
                              ),
                            ), // Text에 underline을 추가하면, 한글 이슈로 빈칸과 높낮이가 안 맞음.
                            child: Text('인증번호 재발송',
                                style: TextStyle(
                                    color: ColorConstants.gray, height: 1.0)),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              mutate(getValidatedData().phone);
                            }
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
