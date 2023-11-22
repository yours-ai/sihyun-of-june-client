import 'package:flutter/material.dart';

class ModalDescriptionWidget extends StatelessWidget {
  final String? description;
  final Widget? descriptionWidget;

  const ModalDescriptionWidget({
    super.key,
    this.description,
    this.descriptionWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: descriptionWidget ??
          Text(
            description!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
    );
  }
}
