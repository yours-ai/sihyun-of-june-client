import 'package:flutter/material.dart';
import 'package:project_june_client/constants.dart';

class ModalChoiceWidget extends StatelessWidget {
  final String submitText, cancelText;
  final VoidCallback onSubmit, onCancel;
  final String? submitSuffix;

  const ModalChoiceWidget({
    super.key,
    required this.submitText,
    required this.cancelText,
    required this.onSubmit,
    required this.onCancel,
    this.submitSuffix,
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
          height: 13,
        ),
        FilledButton(
          onPressed: onSubmit,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                submitText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeightConstants.semiBold,
                  height: 1.0,
                ),
              ),
              submitSuffix != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Text(
                        submitSuffix!,
                        style: TextStyle(
                          fontSize: 14,
                          color: ColorConstants.lightGray.withOpacity(0.5),
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}
