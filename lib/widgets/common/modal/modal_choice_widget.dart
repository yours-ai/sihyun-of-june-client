import 'package:flutter/material.dart';
import 'package:project_june_client/constants.dart';

class ModalChoiceWidget extends StatelessWidget {
  final String submitText, cancelText;
  final VoidCallback onSubmit, onCancel;

  const ModalChoiceWidget({
    super.key,
    required this.submitText,
    required this.cancelText,
    required this.onSubmit,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(ColorConstants.background),
          ),
          onPressed: onCancel,
          child: Text(
            cancelText,
            style: TextStyle(
              fontSize: 16,
              color: ColorConstants.gray,
              fontWeight: FontWeightConstants.semiBold,
              height: 1.0,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        FilledButton(
          onPressed: onSubmit,
          child: Text(
            submitText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeightConstants.semiBold,
              height: 1.0,
            ),
          ),
        ),
      ],
    );
  }
}
