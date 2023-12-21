import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/widgets/character/view_others.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import '../../actions/character/queries.dart';
import '../../widgets/character/profile_widget.dart';

class MyCharacterScreen extends ConsumerWidget {
  const MyCharacterScreen({super.key});

  @override
  Widget build(context, ref) {
    final query = getCharacterQuery(id: ref.watch(selectedCharacterProvider)!);
    return QueryBuilder(
      query: query,
      builder: (context, state) {
        if (state.status == QueryStatus.success) {
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
                    name: state.data!.name,
                    characterInfo: state.data!.character_info!,
                    primaryColor: Color(state.data!.theme!.colors!.primary!),
                  ),
                  ViewOthersWidget(excludeId: state.data!.id),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
