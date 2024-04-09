import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/providers/character_provider.dart';

class ModalChoiceWidget extends ConsumerWidget {
  final String submitText, cancelText;
  final Future<void> Function() onSubmit, onCancel;
  final String? submitSuffix;
  final bool isDefaultButton;

  const ModalChoiceWidget({
    super.key,
    required this.submitText,
    required this.cancelText,
    required this.onSubmit,
    required this.onCancel,
    this.submitSuffix,
    this.isDefaultButton = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AsyncButtonBuilder(
            onPressed: onCancel,
            builder: (context, child, callback, buttonState) {
              return OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorConstants.background),
                  ),
                  onPressed: callback,
                  child: child);
            },
            child: Text(
              cancelText,
              style: TextStyle(
                fontSize: 16,
                color: ColorConstants.gray,
                fontWeight: FontWeightConstants.semiBold,
                height: 1.0,
              ),
            )),
        const SizedBox(
          height: 13,
        ),
        AsyncButtonBuilder(
          onPressed: onSubmit,
          builder: (context, child, callback, buttonState) {
            return FilledButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    isDefaultButton
                        ? Color(ProjectConstants.defaultTheme.colors.primary)
                        : Color(
                            ref
                                    .watch(selectedCharacterProvider)
                                    ?.theme
                                    .colors
                                    .primary ??
                                ProjectConstants.defaultTheme.colors.primary,
                          ),
                  ),
                ),
                onPressed: callback,
                child: child);
          },
          child: submitSuffix == null
              ? Text(
                  submitText,
                  style: modalTextStyle,
                )
              : TextWithSuffix(
                  buttonText: submitText,
                  suffixText: submitSuffix!,
                ),
        ),
      ],
    );
  }
}

class TextWithSuffix extends Row {
  TextWithSuffix({
    super.key,
    required String buttonText,
    required String suffixText,
    TextStyle? textStyle,
    TextStyle? suffixStyle,
  }) : super(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: modalTextStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Text(
                suffixText,
                style: TextStyle(
                  fontSize: 14,
                  color: ColorConstants.veryLightGray.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
            )
          ],
        );
}

final modalTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeightConstants.semiBold,
  height: 1.0,
);
