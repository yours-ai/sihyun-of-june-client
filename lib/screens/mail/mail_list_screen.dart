import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/widgets/mail_list/empty_mail_list_widget.dart';
import 'package:project_june_client/widgets/mail_list/mail_list_widget.dart';
import 'package:project_june_client/widgets/mail_list/tutorial_overlay_widget.dart';
import 'package:project_june_client/widgets/notification/notification_permission_check.dart';

import '../../actions/notification/queries.dart';

class MailListScreen extends ConsumerStatefulWidget {
  const MailListScreen({super.key});

  @override
  MailListScreenState createState() => MailListScreenState();
}

class MailListScreenState extends ConsumerState<MailListScreen> with SingleTickerProviderStateMixin {
  bool? hasCharacter;
  final GlobalKey _targetKey = GlobalKey();
  OverlayEntry? overlayEntry;
  AnimationController? tutorialController;

  @override
  void initState() {
    super.initState();
    tutorialController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100), // 애니메이션 지속 시간
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final myCharactersRawData = await getRetrieveMyCharacterQuery().result;
      setState(() {
        hasCharacter = !(myCharactersRawData.data == null ||
            myCharactersRawData.data!.isEmpty);
      });

      changeProfileList();
    });
  }

  void changeProfileList() {
    final RenderObject? renderBox =
    _targetKey.currentContext?.findRenderObject();
    if (renderBox is RenderBox) {
      final Offset offset = renderBox.localToGlobal(Offset.zero);
      overlayEntry = OverlayEntry(
        builder: (context) => TutorialOverlayWidget(
          hideOverlay: hideOverlay,
          offset: offset,
          tutorialController: tutorialController!,
        ),
      );
      Overlay.of(context).insert(overlayEntry!);
      tutorialController!.forward();
    }
  }

  void hideOverlay() {
    tutorialController!.reverse().then((_) {
      overlayEntry!.remove();
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
      key: _targetKey,
      children: [
        QueryBuilder(
          query: getIsNotificationAcceptedQuery(),
          builder: (context, state) {
            return state.data == false
                ? const RequestNotificationPermissionWidget()
                : const SizedBox.shrink();
          },
        ),
        if (hasCharacter!)
          const MailListWidget()
        else
          const EmptyMailListWidget(),
      ],
    );
  }
}
