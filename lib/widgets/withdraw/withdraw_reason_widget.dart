import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/main.dart';

class WithDrawReasonWidget extends ConsumerStatefulWidget {
  bool isChecked;
  final String reasonKeyword;
  final String reasonText;
  final void Function(String) onQuitResponse;

  WithDrawReasonWidget(
      {super.key,
      required this.reasonKeyword,
      required this.reasonText,
      required this.onQuitResponse,
      required this.isChecked});

  @override
  WithDrawReasonWidgetState createState() => WithDrawReasonWidgetState();
}

class WithDrawReasonWidgetState extends ConsumerState<WithDrawReasonWidget> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      activeColor: Color(ref.watch(characterThemeProvider).colors!.primary!),

        visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
        contentPadding: const EdgeInsets.all(0),
        controlAffinity: ListTileControlAffinity.leading,
        value: widget.isChecked,
        onChanged: (bool? value) {
          setState(() {
            widget.onQuitResponse(widget.reasonKeyword);
          });
        },
        title: Text(widget.reasonText));
  }
}
