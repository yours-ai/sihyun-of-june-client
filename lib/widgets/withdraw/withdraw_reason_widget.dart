import 'package:flutter/material.dart';
import 'package:project_june_client/actions/auth/dtos.dart';

class WithDrawReasonWidget extends StatefulWidget {
  String reasonKeyword;
  final String reasonText;
  final void Function(String) onQuitResponse;

  WithDrawReasonWidget(
      {super.key,
      required this.reasonKeyword,
      required this.reasonText,
      required this.onQuitResponse});

  @override
  State<WithDrawReasonWidget> createState() => _WithDrawReasonWidgetState();
}

class _WithDrawReasonWidgetState extends State<WithDrawReasonWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
        contentPadding: const EdgeInsets.all(0),
        controlAffinity: ListTileControlAffinity.leading,
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
            widget.onQuitResponse(widget.reasonKeyword);
          });
        },
        title: Text(widget.reasonText));
  }
}
