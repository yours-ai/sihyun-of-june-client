import 'package:flutter/material.dart';
import 'package:project_june_client/actions/character/models/CharacterColors.dart';
import 'package:project_june_client/actions/character/models/CharacterTheme.dart';
import 'package:project_june_client/actions/notification/queries.dart';
import 'package:project_june_client/globals.dart';
import 'package:project_june_client/router.dart';
import 'package:project_june_client/services.dart';

SnackBar createNotificationSnackbar({
  required String snackBarText,
  required CharacterColors characterColors,
  int? notificationId,
  String? redirectLink,
}) {
  return SnackBar(
    backgroundColor: Color(characterColors.inverse_surface!), // inverse_surface
    content: Text(snackBarText,
        style: TextStyle(
          fontSize: 14,
          height: 20 / 14,
          color:
              Color(characterColors.inverse_on_surface!), // inverse_on_surface
        )),
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: '확인',
      textColor: Color(characterColors.inverse_primary!), // inverse_primary
      onPressed: () {
        // id의 유무는 전체에게 보내면 id가 없고, 개인에게 보내면 id가 있음.
        if (notificationId == null || notificationId.isNaN) {
          router.push("/notifications"); // 전체에게 보낼때
          return;
        } else {
          final mutation = readNotificationMutation(
            onSuccess: (res, arg) {
              notificationService.routeRedirectLink(
                  redirectLink); // 개인한테 보냈는데, link가 있는 경우. 예) 캐릭터가 보낸 메일
              scaffoldMessengerKey.currentState
                  ?.hideCurrentSnackBar(); // 개인한테 보냈는데, link가 없는 경우. 예) 포인트 쌓임
            },
            refetchQueries: ["list-app-notifications"],
          );
          mutation.mutate(notificationId);
        }
      },
    ),
  );
}
