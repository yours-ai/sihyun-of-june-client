import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/actions/character/models/character.dart';
import 'package:project_june_client/actions/character/models/character_today.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/common/change_character_widget.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/common/top_navbar.dart';

class HomeWidget extends StatefulWidget {
  final Character selectedCharacter;

  const HomeWidget(this.selectedCharacter, {super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final GlobalKey _changeCharacterKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TitleLayout(
        title: TopNavbarWidget(
          selectedCharacter: widget.selectedCharacter,
          titleText: 'HOME',
        ),
        body: QueryBuilder(
            query: fetchCharacterTodayQuery(widget.selectedCharacter
                .assigned_characters!.last.assigned_character_id),
            builder: (context, characterTodayState) {
              return QueryBuilder(
                  query: fetchMeQuery(),
                  builder: (context, meState) {
                    if (characterTodayState.data == null ||
                        characterTodayState.status != QueryStatus.success ||
                        meState.data == null ||
                        meState.status != QueryStatus.success) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    final CharacterToday characterToday =
                        characterTodayState.data!;
                    final splitText = characterToday.text.split('\n');
                    return Stack(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                              child: Column(
                                children: [
                                  Text(
                                    splitText.first,
                                    style: homeWidgetTextStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        splitText.last,
                                        style: homeWidgetTextStyle,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(width: 5),
                                      ExtendedImage.asset(
                                        'assets/images/weather/${characterToday.weather}.png',
                                        width: 25,
                                        height: 25,
                                      )
                                    ],
                                  ),
                                  characterService.buildHomeTodayWidget(
                                    is30daysFinished:
                                        meState.data!.is_30days_finished,
                                    characterToday: characterToday,
                                    firstName:
                                        widget.selectedCharacter.first_name,
                                    characterColors:
                                        widget.selectedCharacter.theme.colors,
                                    context: context,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 20,
                          right: 26,
                          child: ChangeCharacterWidget(
                            key: _changeCharacterKey,
                            targetKey: _changeCharacterKey,
                            parentContext: context,
                          ),
                        ),
                      ],
                    );
                  });
            }),
      ),
    );
  }
}

final homeWidgetTextStyle = TextStyle(
  fontFamily: 'NanumJungHagSaeng',
  color: ColorConstants.primary,
  fontSize: 21,
  height: 1,
  letterSpacing: 2,
  fontWeight: FontWeight.w600,
);
