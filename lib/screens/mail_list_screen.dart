import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:project_june_client/actions/auth/actions.dart';
import 'package:project_june_client/actions/mails/queries.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';

class MailListScreen extends StatelessWidget {
  const MailListScreen({super.key});

  @override
  Widget build(context) {

    return SafeArea(
      child: TitleLayout(
        titleText: '받은 편지함',
        body: QueryBuilder(
            query: getMailListQuery(),
            builder: (context, state) {
              if (state.status == QueryStatus.loading)
                return const CircularProgressIndicator();
              if (state.status == QueryStatus.error)
                return Text(state.error.toString());
              return Column(
                children: state.data
                        ?.map((mail) => Text(mail.description))
                        .toList() ??
                    [],
              );
            }),
      ),
    );
  }
}
