import 'package:flutter/material.dart';

class WithDrawReasonWidget extends StatefulWidget {
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
  State<WithDrawReasonWidget> createState() => _WithDrawReasonWidgetState();
}

class _WithDrawReasonWidgetState extends State<WithDrawReasonWidget> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
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
