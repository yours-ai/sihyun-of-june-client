import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/actions.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/actions/character/models/character.dart';
import 'package:project_june_client/actions/character/models/character_colors.dart';
import 'package:project_june_client/actions/character/models/character_image.dart';
import 'package:project_june_client/actions/character/models/character_today.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/globals.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/router.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/character_change_modal.dart';
import 'package:project_june_client/widgets/home_today_widget.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class CharacterService {
  const CharacterService();

  List<CharacterImage> selectStackedImageList(List<CharacterImage> imageList) {
    final revealedImageList =
        imageList.where((image) => image.is_blurred == false).toList();
    if (revealedImageList.length >= 3) {
      return revealedImageList.sublist(revealedImageList.length - 3);
    }
    return List.from(imageList.sublist(0, 3 - revealedImageList.length))
      ..addAll(revealedImageList);
  }

  CharacterImage getMainImage(List<CharacterImage> imageList) {
    final mainImageList =
        imageList.where((image) => image.is_main == true).toList();
    return mainImageList.first;
  }

  List<Widget> addBlur() {
    return [
      Positioned.fill(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      Positioned.fill(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ),
    ];
  }

  List<int> getCharacterIds(List<Character> characterList) {
    return characterList.map((character) => character.id).toList();
  }

  Future<bool> checkCanRetest() async {
    final myCharactersQuery = await fetchMyCharactersQuery().result;
    final hasCharacter =
        myCharactersQuery.data != null && myCharactersQuery.data!.isNotEmpty;
    final myCharacters = myCharactersQuery.data;
    if (hasCharacter == false || myCharacters == null || myCharacters.isEmpty) {
      return true;
    }
    final allCharacters = await fetchAllCharactersQuery().result;
    final canRetest = myCharacters.length != allCharacters.data!.length;
    return canRetest;
  }

  Future<void> _throwServerError(
    dynamic error, {
    required String errorSource,
    required dynamic stackTrace,
  }) async {
    Sentry.captureException(error, stackTrace: stackTrace);
    await logout();
    router.go(RoutePaths.landing);
    scaffoldMessengerKey.currentState?.showSnackBar(
      const SnackBar(
        content: Text(
          '서버에 문제가 발생했습니다. 해당 현상이 반복되면 카카오톡 채널로 문의주세요.',
        ),
      ),
    );
    throw Exception('해당 문제는 $errorSource 에서 발생했습니다.');
  }

  Future<void> resetProviderOfCharacter(WidgetRef ref) async {
    try {
      final charactersAndActiveCharacter =
          await _getCharacterListAndActiveCharacter(ref);
      if (!charactersAndActiveCharacter.hasCharacter) {
        return;
      }
      final activeCharacter = charactersAndActiveCharacter.activeCharacter!;
      ref.read(selectedCharacterProvider.notifier).state = activeCharacter;
    } catch (error, stackTrace) {
      _throwServerError(
        error,
        errorSource: 'resetProviderOfCharacter',
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> refreshProviderOfCharacter(WidgetRef ref) async {
    try {
      final charactersAndActiveCharacter =
          await _getCharacterListAndActiveCharacter(ref);
      if (!charactersAndActiveCharacter.hasCharacter) {
        return;
      }
      if (ref.read(selectedCharacterProvider) != null) {
        final selectedCharacter = charactersAndActiveCharacter
            .getSelectedCharacter(ref.read(selectedCharacterProvider)!.id);
        ref.read(selectedCharacterProvider.notifier).state = selectedCharacter;
      }
    } catch (error, stackTrace) {
      _throwServerError(
        error,
        errorSource: 'refreshProviderOfCharacter',
        stackTrace: stackTrace,
      );
    }
  }

  Future<_CharactersAndActiveCharacter> _getCharacterListAndActiveCharacter(
      WidgetRef ref) async {
    final myCharacters =
        await fetchMyCharactersQuery().refetch().then((value) => value.data);
    if (myCharacters == null || myCharacters.isEmpty) {
      ref.read(activeCharacterProvider.notifier).state = null;
      ref.read(selectedCharacterProvider.notifier).state = null;
      return _CharactersAndActiveCharacter(null, null);
    }
    final activeCharacter = myCharacters.firstWhere(
      (character) => character.assigned_characters!
          .any((assignedCharacter) => assignedCharacter.is_active),
      orElse: () => throw Exception('Active character not found.'),
    );
    ref.read(activeCharacterProvider.notifier).state = activeCharacter;
    return _CharactersAndActiveCharacter(myCharacters, activeCharacter);
  }

  void redirectRetest(
    String? activeCharacterFirstName,
    bool isSelectedCharacter,
    BuildContext context,
  ) async {
    if (activeCharacterFirstName == null) return;
    final bool is30DaysFinished = await fetchMeQuery()
        .result
        .then((value) => value.data!.is_30days_finished);
    if (isSelectedCharacter && is30DaysFinished) {
      context.push(
        RoutePaths.retest,
        extra: <String, dynamic>{
          'firstName': activeCharacterFirstName,
        },
      );
    }
  }

  void showCharacterChangeModal({
    required List<Character> characterList,
    required BuildContext context,
    required WidgetRef ref,
  }) {
    final selectedCharacter = ref.read(selectedCharacterProvider);
    final activeCharacterFirstName =
        ref.read(activeCharacterProvider)?.first_name;
    final unselectedCharacterList = characterList
        .where((character) => character.id != selectedCharacter?.id)
        .toList();
    showModalBottomSheet(
      backgroundColor: ColorConstants.veryLightGray,
      context: context,
      showDragHandle: true,
      builder: (context) {
        return CharacterChangeModal(
          selectedCharacter: selectedCharacter,
          unselectedCharacterList: unselectedCharacterList,
          activeCharacterFirstName: activeCharacterFirstName,
        );
      },
    );
  }

  HomeEnum checkTodayStatus(
      bool is30daysFinished, CharacterToday characterToday) {
    if (is30daysFinished) {
      return HomeEnum.thirtyDaysFinished;
    } else {
      final hasMail = characterToday.mail != null;
      if (hasMail) {
        if (characterToday.mail!.is_read) {
          final bool hasReply =
              characterToday.mail!.replies?.isNotEmpty ?? false;
          if (!hasReply) {
            return HomeEnum.needReply;
          } else {
            Sentry.captureMessage(
                '${characterToday.mail!.id}메일에 답장했으나 mail이 null로 처리되지 않았습니다.');
            final retryCharacterToday = CharacterToday(
              text: characterToday.text,
              weather: characterToday.weather,
              next_mail_available_at: characterToday.next_mail_available_at,
              is_next_mail_last: characterToday.is_next_mail_last,
              is_last_mail: characterToday.is_last_mail,
              is_just_replied: characterToday.is_just_replied,
              mail: null,
            );
            return checkTodayStatus(is30daysFinished, retryCharacterToday);
          }
        } else {
          if (characterToday.is_last_mail) {
            return HomeEnum.arrivedLastMail;
          } else {
            return HomeEnum.arrivedNewMail;
          }
        }
      } else {
        if (characterToday.is_just_replied) {
          return HomeEnum.justReplied;
        } else {
          if (characterToday.is_next_mail_last) {
            return HomeEnum.willBeArrivedLastMail;
          } else {
            return HomeEnum.willBeArrivedMail;
          }
        }
      }
    }
  }

  HomeTodayWidget buildHomeTodayWidget({
    required bool is30daysFinished,
    required CharacterToday characterToday,
    required String firstName,
    required BuildContext context,
    required CharacterColors characterColors,
  }) {
    final todayStatus = checkTodayStatus(is30daysFinished, characterToday);
    switch (todayStatus) {
      case HomeEnum.thirtyDaysFinished:
        return HomeTodayWidget(
          imageSrc: 'assets/images/home/30days_finished.png',
          text: '$firstName이와의 시간은 이제 끝이지만\n추억은 영원히 이곳에 남아있어',
          buttonColor: Color(characterColors.primary),
          buttonText: '엔딩 보기',
          onPressed: () {}, // TODO: 엔딩보기 기능 추가
        );
      case HomeEnum.needReply:
        return HomeTodayWidget(
          imageSrc: 'assets/images/home/need_reply.png',
          text: '편지에 답장을 써주면\n내가 $firstName이에게 전해줄게!',
          buttonColor: Color(characterColors.primary),
          buttonText: '답장 쓰기',
          onPressed: () {
            transactionService.checkMailTicketAndRedirect(
              context: context,
              assignId: characterToday.mail!.assign,
              characterColors: characterColors,
              mailId: characterToday.mail!.id,
            );
          },
        );
      case HomeEnum.arrivedLastMail:
        return HomeTodayWidget(
          imageSrc: 'assets/images/home/open_mail.png',
          text: '아쉽지만 이제 마지막 편지야\n한번 확인해볼까?',
          buttonColor: Color(characterColors.primary),
          buttonText: '열기',
          onPressed: () {
            transactionService.checkMailTicketAndRedirect(
              context: context,
              assignId: characterToday.mail!.assign,
              characterColors: characterColors,
              mailId: characterToday.mail!.id,
            );
          },
        );
      case HomeEnum.arrivedNewMail:
        return HomeTodayWidget(
          imageSrc: 'assets/images/home/open_mail.png',
          text: '새 편지가 왔네\n한번 확인해봐!',
          buttonColor: Color(characterColors.primary),
          buttonText: '열기',
          onPressed: () {
            transactionService.checkMailTicketAndRedirect(
              context: context,
              assignId: characterToday.mail!.assign,
              characterColors: characterColors,
              mailId: characterToday.mail!.id,
            );
          },
        );
      case HomeEnum.justReplied:
        return HomeTodayWidget(
          imageSrc: 'assets/images/home/will_be_arrived.png',
          text: '편지는 내가 잘 전달해줄게!\n$firstName이가 분명 기뻐할 거야',
          buttonColor: Color(characterColors.primary),
        );
      case HomeEnum.willBeArrivedMail:
        final arrivedAt = mailService.getNextMailReceiveTimeStr(
          characterToday.next_mail_available_at,
        );
        return HomeTodayWidget(
          imageSrc: 'assets/images/home/will_be_arrived.png',
          text: '$firstName이의 편지는 $arrivedAt에\n도착할 예정이야',
          buttonColor: Color(characterColors.primary),
        );
      case HomeEnum.willBeArrivedLastMail:
        final arrivedAt = mailService.getNextMailReceiveTimeStr(
          characterToday.next_mail_available_at,
        );
        return HomeTodayWidget(
          imageSrc: 'assets/images/home/will_be_arrived.png',
          text: '$firstName이의 마지막 편지는\n$arrivedAt에\n도착할 예정이야',
          buttonColor: Color(characterColors.primary),
        );
    }
  }
}

class _CharactersAndActiveCharacter {
  final List<Character>? myCharacters;
  final Character? activeCharacter;

  _CharactersAndActiveCharacter(this.myCharacters, this.activeCharacter);

  Character getSelectedCharacter(int selectedCharacterId) {
    return myCharacters!.firstWhere(
      (character) => character.id == selectedCharacterId,
      orElse: () => throw Exception('Selected character maybe be deleted.'),
    );
  }

  bool get hasCharacter => activeCharacter != null && myCharacters != null;
}
