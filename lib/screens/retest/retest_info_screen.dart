import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/widgets/character/not_chosen_list_widget.dart';
import 'package:project_june_client/widgets/retest/retest_layout_widget.dart';

import '../../actions/character/models/Character.dart';
import '../../actions/character/queries.dart';
import '../../constants.dart';
import '../../providers/user_provider.dart';

class RetestInfoScreen extends ConsumerWidget {
  final String firstName;
  final List<int> characterIds;

  const RetestInfoScreen({
    super.key,
    required this.firstName,
    required this.characterIds,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isEnableToRetest = ref.watch(isEnableToRetestProvider);
    return RetestLayoutWidget(
      firstName: firstName,
      title:
          '$firstName이와의 시간, 즐거우셨나요?\n${isEnableToRetest ? '이제, 새로운 상대를\n만날 수 있어요.' : '조금 더 이어갈 수 있어요.'}',
      body: QueryBuilder<List<Character>>(
        query: getAllCharactersQuery(),
        builder: (context, state) {
          if (state.data != null) {
            var filteredCharacters = isEnableToRetest
                ? state.data!
                    .where((character) => !characterIds.contains(character.id))
                    .toList()
                : state.data!;
            return NotChosenListWidget(
              isEnableToRetest: isEnableToRetest,
              filteredCharacters: filteredCharacters,
            );
          }
          return const SizedBox.shrink();
        },
      ),
      action: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FilledButton(
            style: Theme.of(context).filledButtonTheme.style!.copyWith(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(ColorConstants.gray),
                ),
            onPressed: () {
              context.push(
                '/retest/extend',
                extra: firstName,
              );
            },
            child: Text('$firstName이와의 시간 이어가기'),
          ),
          const SizedBox(
            height: 13,
          ),
          FilledButton(
            style: isEnableToRetest
                ? null
                : Theme.of(context).filledButtonTheme.style!.copyWith(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorConstants.veryLightGray),
                    ),
            onPressed: () {
              if (!isEnableToRetest) {
                return;
              }
              context.push(
                '/retest/confirm',
                extra: firstName,
              );
            },
            child: Text(
              '새로운 상대 만나기',
              style: TextStyle(
                  color: ColorConstants.background
                      .withOpacity(isEnableToRetest ? 1.0 : 0.7)),
            ),
          ),
        ],
      ),
    );
  }
}
