import 'package:flutter/material.dart';
import 'package:project_june_client/actions/character/models/character/character_colors.dart';
import 'package:project_june_client/globals.dart';

SnackBar createSnackBar({
  required String snackBarText,
  required CharacterColors characterColors,
  VoidCallback? onPressed,
}) {
  return SnackBar(
    backgroundColor: Color(characterColors.inverse_surface), // inverse_surface
    content: Text(snackBarText,
        style: TextStyle(
          fontSize: 14,
          height: 20 / 14,
          color:
              Color(characterColors.inverse_on_surface), // inverse_on_surface
        )),
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: '확인',
      textColor: Color(characterColors.inverse_primary), // inverse_primary
      onPressed: onPressed ??
          () {
            scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
          },
    ),
  );
}
