import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/widgets/mail_list/empty_character.dart';
import 'package:project_june_client/widgets/mail_list/mail_list_widget.dart';
import 'package:project_june_client/widgets/notification/notification_permission_check.dart';

import '../../actions/notification/queries.dart';

class MailListScreen extends ConsumerWidget {
  const MailListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCharacter = ref.watch(selectedCharacterProvider);
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
        if (selectedCharacter != null)
          MailListWidget(selectedCharacter)
        else
          const EmptyCharacterWidget('받은 편지함'),
      ],
    );
  }
}
