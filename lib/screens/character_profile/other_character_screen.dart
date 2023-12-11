import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import 'package:project_june_client/widgets/profile_widget.dart';

class OtherCharacterScreen extends StatelessWidget {
  final int id;

  const OtherCharacterScreen({super.key, required this.id});

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
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 28.0,
                vertical: 10,
              ),
              children: [
                ProfileWidget(
                  id: state.data!.id,
                  name: state.data!.name,
                  characterInfo: state.data!.character_info!,
                  primaryColor: Color(state.data!.theme!.colors!.primary!),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
