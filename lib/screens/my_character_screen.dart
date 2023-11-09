import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/character/view_others.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import 'package:project_june_client/widgets/common/dotted_underline.dart';

import '../actions/character/queries.dart';
import '../widgets/profile_widget.dart';

class MyCharacterScreen extends StatelessWidget {
  const MyCharacterScreen({super.key});

  @override
  Widget build(context) {
    final query = getRetrieveMyCharacterQuery();
    return QueryBuilder(
        query: query,
        builder: (context, state) {
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
                    name: state.data!.first.name,
                    age: state.data!.first.age,
                    mbti: state.data!.first.one_line_description,
                    description: state.data!.first.description,
                    imageSrc: state.data!.first.default_image,
                  ),
                  ViewOthersWidget(excludeId: state.data!.first.id),
                ],
              ),
            ),
          );
        });
  }
}
