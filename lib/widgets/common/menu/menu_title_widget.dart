import 'package:flutter/material.dart';
import 'package:project_june_client/constants.dart';

class MenuTitleWidget extends StatelessWidget {
  final String title;

  const MenuTitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.veryLightGray,
      child: Container(
        height: 71,
        padding: const EdgeInsets.only(left: 25),
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 22),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color: ColorConstants.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
