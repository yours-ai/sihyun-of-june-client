import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import 'package:project_june_client/widgets/character/profile_widget.dart';

class CharacterSelectionDecidedCharacterScreen extends StatefulWidget {
  final int id;

  const CharacterSelectionDecidedCharacterScreen({super.key, required this.id});

  @override
  State<CharacterSelectionDecidedCharacterScreen> createState() =>
      _CharacterSelectionDecidedCharacterScreenState();
}

class _CharacterSelectionDecidedCharacterScreenState
    extends State<CharacterSelectionDecidedCharacterScreen> {
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
    final query = getCharacterQuery(id: widget.id);
    return QueryBuilder(
      query: query,
      builder: (context, state) {
        if (state.data == null) {
          return const SizedBox.shrink();
        }
        return Scaffold(
          appBar: const BackAppbar(),
          body: Stack(
            children: [
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                                name: state.data!.name,
                                characterInfo: state.data!.character_info!,
                                primaryColor:
                                    Color(state.data!.theme!.colors!.primary!),
                                isImageUpdated: state.data!.is_image_updated,
                              ),
                            ),
                            FilledButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Color(state.data!.theme!.colors!.primary!),
                                ),
                              ),
                              onPressed: () => context.pushNamed(
                                DecidedRouteNames.confirm,
                                queryParameters: {
                                  'id': widget.id.toString(),
                                  'firstName': state.data!.first_name!,
                                  'primaryColor': state
                                      .data!.theme!.colors!.primary!
                                      .toString(),
                                  'secondaryColor': state
                                      .data!.theme!.colors!.secondary!
                                      .toString(),
                                },
                              ),
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
                              '아래로 내려보세요!',
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
