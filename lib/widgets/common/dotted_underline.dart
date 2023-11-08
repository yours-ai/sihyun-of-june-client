import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class DottedUnderline extends StatelessWidget {
  final double margin;

  const DottedUnderline(
    this.margin, {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin),
      height: 2,
      decoration: DottedDecoration(
        shape: Shape.line,
        linePosition: LinePosition.top,
        color: ColorConstants.neutral,
        dash: const [5, 5],
        strokeWidth: 1,
      ),
    );
  }
}
