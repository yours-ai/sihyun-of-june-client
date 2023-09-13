import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/actions/auth/dtos.dart';

import '../common/title_layout.dart';

class PhoneTabWidget extends StatefulWidget {
  final void Function(ValidatedPhoneDTO dto) onSmsSend;

  const PhoneTabWidget({Key? key, required this.onSmsSend}) : super(key: key);

  @override
  State<PhoneTabWidget> createState() => _PhoneTabWidgetState();
}

class _PhoneTabWidgetState extends State<PhoneTabWidget> {
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
    final mutation = getSmsSendMutation(
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
        child: TitleLayout(
          titleText: '시작하려면\n전화번호가 필요해요.',
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
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
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        minLines: 1,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          hintText: '01012345678',
                          hintStyle: TextStyle(
                            fontFamily: 'MaruBuri',
                            fontSize: 25,
                            color: ColorConstants.neutral,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontFamily: 'MaruBuri',
                          fontSize: 25,
                          color: ColorConstants.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: OutlinedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                mutate(getValidatedData().phone);
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
