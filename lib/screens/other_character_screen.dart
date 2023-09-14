import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/widgets/profile_widget.dart';

import '../constants.dart';

class OtherCharacterScreen extends StatelessWidget {
  final int? id;

  const OtherCharacterScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return QueryBuilder(
      query: getCharacterQuery(id: id ?? 0),
      builder: (context, state) {
        if (state.data == null) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: ColorConstants.background,
              elevation: 0,
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: Container(
                  padding: const EdgeInsets.only(left: 23),
                  child: Icon(
                    PhosphorIcons.arrow_left,
                    color: ColorConstants.black,
                    size: 32,
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      children: [
                        ProfileWidget(
                            name: state.data!.name,
                            age: state.data!.age,
                            mbti: state.data!.MBTI,
                            description: state.data!.description,
                            imageSrc: state.data!.image),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
