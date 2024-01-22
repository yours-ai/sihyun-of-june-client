import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';

class NewUserAssignmentStartingScreen extends StatelessWidget {
  const NewUserAssignmentStartingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.background,
        elevation: 0,
        title: const SizedBox.shrink(),
      ),
      body: SafeArea(
        child: QueryBuilder(
          query: getRetrieveMeQuery(),
          builder: (context, state) {
            if (state.data == null) {
              return const SizedBox.shrink();
            }
            return TitleLayout(
              withAppBar: true,
              title: Text(
                '이제, ${state.data!.first_name}님과 편지를\n나눌 상대를 정해드리려 해요.',
                style: Theme.of(context).textTheme.titleLarge,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
              body: Center(
                  child: Image.asset('assets/images/landing/test_image.png')),
              actions: FilledButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    ColorConstants.pink,
                  ),
                ),
                onPressed: () {
                  context.go('/assignment');
                },
                child: const Text('다음'),
              ),
            );
          },
        ),
      ),
    );
  }
}
