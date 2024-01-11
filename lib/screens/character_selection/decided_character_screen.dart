import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import 'package:project_june_client/widgets/character/profile_widget.dart';

class CharacterSelectionDecidedCharacterScreen extends StatelessWidget {
  final int id;

  const CharacterSelectionDecidedCharacterScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final query = getCharacterQuery(id: id);
    return QueryBuilder(
      query: query,
      builder: (context, state) {
        if (state.data == null) {
          return const SizedBox.shrink();
        }
        return Scaffold(
          appBar: const BackAppbar(),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28.0,
                      vertical: 10,
                    ),
                    children: [
                      ProfileWidget(
                        name: state.data!.name,
                        characterInfo: state.data!.character_info!,
                        primaryColor:
                            Color(state.data!.theme!.colors!.primary!),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28.0,
                    vertical: 20,
                  ),
                  child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(state.data!.theme!.colors!.primary!),
                      ),
                    ),
                    onPressed: () => context.pushNamed(
                      DecidedRouteNames.confirm,
                      queryParameters: {
                        'id': id.toString(),
                        'firstName': state.data!.first_name!,
                        'primaryColor':
                            state.data!.theme!.colors!.primary!.toString(),
                        'secondaryColor':
                            state.data!.theme!.colors!.secondary!.toString(),
                      },
                    ),
                    child: const Text('다음'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
