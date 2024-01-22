import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/widgets/character/profile_widget.dart';
import 'package:project_june_client/widgets/character/view_others_widget.dart';

import '../../screens/character_test/choice_screen.dart';

class TestCharacterDetailWidget extends ConsumerStatefulWidget {
  final void Function(ActiveScreen) onActiveScreen;
  final void Function({
    required TestReason reason,
    required int testId,
    required String firstName,
    required int characterId,
  }) onTestInfo;

  const TestCharacterDetailWidget(
      {super.key, required this.onActiveScreen, required this.onTestInfo});

  @override
  TestCharacterDetailWidgetState createState() =>
      TestCharacterDetailWidgetState();
}

class TestCharacterDetailWidgetState
    extends ConsumerState<TestCharacterDetailWidget> {
  double _toolTipOpacity = 1.0; // 그라데이션과 메시지의 투명도

  void _updateOpacity(ScrollNotification notification) {
    if (notification.metrics.pixels > 50) {
      setState(() => _toolTipOpacity = 0.0);
    } else {
      setState(() => _toolTipOpacity = 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = getPendingTestQuery();
    return QueryBuilder(
      query: query,
      builder: (context, state) {
        Character? character;
        if (state.data == null) {
          return const SizedBox.shrink();
        }
        String testReason = state.data!['test_reason'];
        character = Character.fromJson(state.data!['character']);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(characterThemeProvider.notifier).state = character!.theme;
        });
        return Scaffold(
          body: Stack(
            children: [
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Expanded(
                      child: NotificationListener(
                        onNotification: (ScrollNotification notification) {
                          _updateOpacity(notification);
                          return true;
                        },
                        child: ListView(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ProfileWidget(
                                name: character.name,
                                characterInfo: character.character_info,
                                primaryColor:
                                    Color(character.theme.colors.primary),
                                isImageUpdated: character.is_image_updated,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ViewOthersWidget(excludeId: character.id),
                            ),
                            FilledButton(
                              onPressed: () {
                                widget.onTestInfo(
                                    reason: testReason == 'NEW_USER'
                                        ? TestReason.newUser
                                        : TestReason.retest,
                                    testId: state.data!['test_id'],
                                    firstName: character!.first_name,
                                    characterId: character.id);
                                widget.onActiveScreen(ActiveScreen.confirm);
                              },
                              child: const Text('다음'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: IgnorePointer(
                  ignoring: _toolTipOpacity == 0.0,
                  child: AnimatedOpacity(
                    opacity: _toolTipOpacity,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.transparent
                          ],
                        ),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: ColorConstants.background,
                              size: 32,
                            ),
                            Text(
                              '다른 상대도 살펴보세요!',
                              style: TextStyle(
                                color: ColorConstants.background,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
