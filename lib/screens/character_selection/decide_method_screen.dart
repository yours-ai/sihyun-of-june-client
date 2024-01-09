import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/actions/notification/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/providers/user_provider.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/character/not_chosen_list_widget.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';

class CharacterSelectionDecideMethodScreen extends ConsumerWidget {
  const CharacterSelectionDecideMethodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const BackAppbar(),
      body: SafeArea(
        child: TitleLayout(
          title: Text(
            '혹시\n원하는 상대가 있으신가요?',
            style: Theme.of(context).textTheme.titleLarge,
            softWrap: true,
            textAlign: TextAlign.center,
          ),
          body: const SizedBox(),
          actions: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MutationBuilder(
                mutation: readAllNotificationMutation(),
                //TODO: re-test 결제 뮤테이션으로 바꿔야함
                //TODO: onSuccess 시에 starting screen으로 보내야함
                builder: (context, state, mutate) {
                  return FilledButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(state.status !=
                              QueryStatus.loading
                          ? ColorConstants.pink
                          : Color(ColorTheme.defaultTheme.colors!.secondary!)),
                    ),
                    onPressed: () {
                      if (state.status != QueryStatus.loading) {
                        //TODO: re-test mutate로 바꿔야 함
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '누구든 괜찮아요',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeightConstants.semiBold,
                            height: 1.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            '100P',
                            style: TextStyle(
                              fontSize: 14,
                              color: ColorConstants.lightGray.withOpacity(0.5),
                              fontWeight: FontWeight.bold,
                              height: 1.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 13,
              ),
              MutationBuilder(
                mutation: readAllNotificationMutation(),
                //TODO: 캐릭터 선택권 결제 뮤테이션으로 바꿔야함
                //TODO: onSuccess 시에 starting screen으로 보내야함
                builder: (context, state, mutate) {
                  return FilledButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(state.status !=
                              QueryStatus.loading
                          ? ColorConstants.pink
                          : Color(ColorTheme.defaultTheme.colors!.secondary!)),
                    ),
                    onPressed: () {
                      if (state.status != QueryStatus.loading) {
                        context.go('/character-selection-deciding'); //TODO: 캐릭터 선택 mutate로 바꿔야 함
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '원하는 상대로 해주세요',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeightConstants.semiBold,
                            height: 1.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            '50코인',
                            style: TextStyle(
                              fontSize: 14,
                              color: ColorConstants.lightGray.withOpacity(0.5),
                              fontWeight: FontWeight.bold,
                              height: 1.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
