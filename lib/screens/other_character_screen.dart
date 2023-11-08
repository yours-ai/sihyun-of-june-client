import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import 'package:project_june_client/widgets/profile_widget.dart';

import '../constants.dart';

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
          appBar: BackAppbar(),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 28.0,
                vertical: 10,
              ),
              children: [
                ProfileWidget(
                  name: state.data!.name,
                  age: state.data!.age,
                  mbti: state.data!.MBTI,
                  description: state.data!.description,
                  imageSrc: state.data!.image,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
