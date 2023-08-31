import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:project_june_client/constants.dart';

class ModalWidget extends StatelessWidget {
  const ModalWidget({
    Key? key,
    required this.description,
    required this.moreDescription,
    required this.button1,
    required this.button2,
    required this.action,
  }) : super(key: key);

  final String description, button1, button2;
  final VoidCallback action;
  final bool moreDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.background,
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0, left: 20, right: 20, bottom:30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  description,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: moreDescription == true ? 26 : 0,
            ),
            Container(
              padding: const EdgeInsets.only(top: 0.0),
              height: moreDescription == true ? 20 : 0,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      '친구가 링크로 가입하면 50',
                      style: TextStyle(
                          fontSize: 14, color: ColorConstants.neutral),
                    ),
                    Icon(PhosphorIcons.coin_vertical,
                        size: moreDescription == true ? 14 : 0, color: ColorConstants.neutral),
                    Text(
                      '을 받아요.',
                      style: TextStyle(
                          fontSize: 14, color: ColorConstants.neutral),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 26,
            ),
            FilledButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(ColorConstants.background),
              ),
              child: Text(
                button1,
                style: TextStyle(
                    fontSize: 14.0, color: ColorConstants.secondary),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            FilledButton(
              onPressed: action,
              child: Text(
                button2,
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
