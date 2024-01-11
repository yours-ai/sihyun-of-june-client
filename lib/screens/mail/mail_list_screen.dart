import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/providers/common_provider.dart';
import 'package:project_june_client/providers/mail_list_provider.dart';
import 'package:project_june_client/services/unique_cachekey_service.dart';
import 'package:project_june_client/widgets/mail_list/change_character_overlay_widget.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/mail_list/empty_mail_list_widget.dart';
import 'package:project_june_client/widgets/mail_list/mail_list_widget.dart';
import 'package:project_june_client/widgets/notification/notification_permission_check.dart';

import '../../actions/character/models/Character.dart';
import '../../actions/mails/queries.dart';
import '../../actions/notification/queries.dart';
import '../../constants.dart';
import '../../services.dart';
import '../../widgets/common/alert/alert_widget.dart';
import '../character_profile/profile_details_screen.dart';

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
      final myCharactersRawData = await getRetrieveMyCharacterQuery().result;
      setState(() {
        hasCharacter = !(myCharactersRawData.data == null ||
            myCharactersRawData.data!.isEmpty);
      });
    });
  }

  @override
  Widget build(context) {
    return QueryBuilder(
      query: getRetrieveMyCharacterQuery(),
      builder: (context, state) {
        if (state.status == QueryStatus.loading) {
          return const SafeArea(
            child: Center(child: CircularProgressIndicator.adaptive()),
          );
        }
        final hasCharacter = !(state.data == null || state.data!.isEmpty);
        return Stack(
          children: [
            QueryBuilder(
              query: getIsNotificationAcceptedQuery(),
              builder: (context, state) {
                return state.data == false
                    ? const RequestNotificationPermissionWidget()
                    : const SizedBox.shrink();
              },
            ),
            if (hasCharacter)
              const MailListWidget()
            else
              const EmptyMailListWidget(),
          ],
        );
      },
    );
  }
}
