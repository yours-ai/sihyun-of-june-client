import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/auth/models/SihyunOfJuneUser.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/character/models/CharacterImage.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/actions/mails/models/Mail.dart';
import 'package:project_june_client/actions/mails/queries.dart';
import 'package:project_june_client/actions/notification/models/AppNotification.dart';
import 'package:project_june_client/actions/notification/queries.dart';
import 'package:project_june_client/contrib/flutter_secure_storage.dart';
import 'package:project_june_client/providers/character_provider.dart';

class FetchService {
  const FetchService();

  Future<List<Character>> fetchMyCharacters() async {
    final myCharacterState = await getRetrieveMyCharacterQuery().result;
    return myCharacterState.data!;
  }

  Future<List<Character>> fetchAllCharacters() async {
    final allCharacterState = await getAllCharactersQuery().result;
    return allCharacterState.data!;
  }

  Future<List<Mail>> fetchMailList(int characterId, int page) async {
    final mailListState = await getListMailQuery(
      characterId: characterId,
      page: page,
    ).result;
    return mailListState.data!;
  }

  Future<List<AppNotification>> fetchNotificationList() async {
    final notificationState = await getListAppNotificationQuery().result;
    return notificationState.data!;
  }

  Future<SihyunOfJuneUser> fetchAuthMe() async {
    final userState = await getRetrieveMeQuery().result;
    return userState.data!;
  }
}
