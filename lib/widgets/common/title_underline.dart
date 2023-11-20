import 'package:flutter/material.dart';
import '../../constants.dart';

class TitleUnderline extends StatelessWidget {
  final String titleText;

  const TitleUnderline({
    super.key,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: ColorConstants.primary,
          ),
        ),
      ),
      child: Text(
        titleText,
        style: Theme.of(context).textTheme.titleLarge,
        softWrap: true,
        textAlign: TextAlign.center,
      ),
    );
  }
}
