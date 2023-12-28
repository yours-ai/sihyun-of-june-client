import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/providers/character_provider.dart';

class ModalChoiceWidget extends ConsumerWidget {
  final String submitText, cancelText;
  final VoidCallback onSubmit, onCancel;
  final String? submitSuffix;
  final QueryStatus? mutationStatus;

  const ModalChoiceWidget({
    super.key,
    required this.submitText,
    required this.cancelText,
    required this.onSubmit,
    required this.onCancel,
    this.submitSuffix,
    this.mutationStatus,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(mutationStatus == null ||
                    mutationStatus != QueryStatus.loading
                ? Color(ref.watch(characterThemeProvider).colors!.primary!)
                : Color(ref.watch(characterThemeProvider).colors!.secondary!)),
          ),
          onPressed: () {
            if (mutationStatus == null ||
                mutationStatus != QueryStatus.loading) {
              onSubmit();
            }
          },
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
