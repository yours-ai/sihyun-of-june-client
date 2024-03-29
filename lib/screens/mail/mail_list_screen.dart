import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/widgets/mail_list/empty_character.dart';
import 'package:project_june_client/widgets/mail_list/mail_list_widget.dart';
import 'package:project_june_client/widgets/notification/notification_permission_check.dart';

import '../../actions/notification/queries.dart';

class MailListScreen extends ConsumerStatefulWidget {
  const MailListScreen({super.key});

  @override
  MailListScreenState createState() => MailListScreenState();
}

class MailListScreenState extends ConsumerState<MailListScreen> {
  bool? hasCharacter;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final myCharactersRawData = await fetchMyCharacterQuery().result;
      setState(() {
        hasCharacter = !(myCharactersRawData.data == null ||
            myCharactersRawData.data!.isEmpty);
      });
    });
  }

  @override
  Widget build(context) {
    if (hasCharacter == null) {
      return const SafeArea(
        child: Center(child: CircularProgressIndicator.adaptive()),
      );
    }
    return Stack(
      children: [
        QueryBuilder(
          query: fetchIsNotificationAcceptedQuery(),
          builder: (context, state) {
            return state.data == false
                ? const RequestNotificationPermissionWidget()
                : const SizedBox.shrink();
          },
        ),
        if (hasCharacter!)
          const MailListWidget()
        else
          const EmptyCharacterWidget("받은 편지함"),
      ],
    );
  }
}
