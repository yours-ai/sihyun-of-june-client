import 'package:flutter/material.dart';
import 'package:project_june_client/constants.dart';

class ModalWidget extends StatelessWidget {
  final String title;
  final Widget description, choiceColumn;

  const ModalWidget({
    Key? key,
    required this.title,
    this.description = const SizedBox(),
    this.choiceColumn = const SizedBox(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.background,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 32.0, left: 20, right: 20, bottom: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
            description,
            const SizedBox(
              height: 26,
            ),
            choiceColumn,
            const SizedBox(
              height: 26,
            ),
          ],
        ),
      ),
    );
  }
}
