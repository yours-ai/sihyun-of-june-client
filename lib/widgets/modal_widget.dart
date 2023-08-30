import 'package:flutter/material.dart';
import 'package:project_june_client/constants.dart';

class ModalWidget extends StatelessWidget {
  const ModalWidget({
    Key? key,
    required this.description,
    required this.button1,
    required this.button2,
    required this.action,
  }) : super(key: key);

  final String description, button1, button2;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 277,
      color: ColorConstants.background,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 32,
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 28),
                child: Text(
                  description,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              height: 26,
            ),
            FilledButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(ColorConstants.background),
              ),
              child: Text(
                button1,
                style: TextStyle(color: ColorConstants.secondary),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: FilledButton(
                onPressed: action,
                child: Text(button2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
