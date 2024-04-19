import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/models/character.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';

class BetweenWidget extends StatelessWidget {
  final Character selectedCharacter;

  const BetweenWidget(
    this.selectedCharacter, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TitleLayout(
          title: const Center(
            child: TitleUnderline(
              titleText: '서로에 대해',
            ),
          ),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('사진올듯'),
                      ],
                    ),
                  ), // TODO: 유월의 짤로 바꾸기
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                    child: Text.rich(
                      TextSpan(
                        text: '${selectedCharacter.first_name}이와 ',
                        style: TextStyle(
                          color: ColorConstants.primary,
                          fontFamily: 'NanumJungHagSaeng',
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: '아는 사이', //TODO: 무슨 사이인지 동적으로 바꿔야함
                            style: TextStyle(
                              color:
                                  Color(selectedCharacter.theme.colors.primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () =>
                              context.push(RoutePaths.betweenRelationship),
                          child: Icon(
                            PhosphorIcons.question,
                            color: ColorConstants.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
