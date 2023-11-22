import 'package:flutter/material.dart';
import 'package:project_june_client/constants.dart';

class ModalChoiceWidget extends StatelessWidget {
  final String? submitText, cancelText;
  final VoidCallback? onSubmit, onCancel;

  const ModalChoiceWidget({
    super.key,
    this.submitText,
    this.cancelText,
    this.onSubmit,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        (cancelText == null || onCancel == null)
            ? const SizedBox.shrink()
            :
        OutlinedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(ColorConstants.background),
          ),
          onPressed: onCancel,
          child: Text(
            cancelText!,
            style: TextStyle(
              fontSize: 16,
              color: ColorConstants.neutral,
              fontWeight: FontWeightConstants.semiBold,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        (submitText == null || onSubmit == null)
            ? const SizedBox.shrink()
            :
        FilledButton(
          onPressed: onSubmit,
          child: Text(
            submitText!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeightConstants.semiBold,
            ),
          ),
        ),
      ],
    );
  }
}
