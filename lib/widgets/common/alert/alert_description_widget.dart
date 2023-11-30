import 'package:flutter/material.dart';
import 'package:word_break_text/word_break_text.dart';

import '../../../constants.dart';

class AlertDescriptionWidget extends StatelessWidget {
  final String? description;

  const AlertDescriptionWidget({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: (description == null || description!.isEmpty)
          ? SizedBox.shrink()
          :
      WordBreakText(description!,
          spacingByWrap: true,
          spacing: 4,
          wrapAlignment: WrapAlignment.center,
          style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
