import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/widgets/character/view_others.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import '../../actions/character/queries.dart';
import '../../widgets/character/profile_widget.dart';

class MyCharacterScreen extends ConsumerStatefulWidget {
  const MyCharacterScreen({super.key});

  @override
  MyCharacterScreenState createState() => MyCharacterScreenState();
}

class MyCharacterScreenState extends ConsumerState<MyCharacterScreen> {
  double _toolTipOpacity = 1.0; // 그라데이션과 메시지의 투명도

  void _updateOpacity(ScrollNotification notification) {
    if (notification.metrics.pixels > 50) {
      setState(() => _toolTipOpacity = 0.0);
    } else {
      setState(() => _toolTipOpacity = 1.0);
    }
  }

  @override
  Widget build(context) {
    final query = getCharacterQuery(id: ref.watch(selectedCharacterProvider)!);
    return QueryBuilder(
      query: query,
      builder: (context, state) {
        if (state.status == QueryStatus.success) {
          return Scaffold(
            appBar: const BackAppbar(),
            body: Stack(
              children: [
                SafeArea(
                  child: NotificationListener(
                    onNotification: (ScrollNotification notification) {
                      _updateOpacity(notification);
                      return true;
                    },
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28.0,
                        vertical: 10,
                      ),
                      children: [
                        ProfileWidget(
                          name: state.data!.name,
                          characterInfo: state.data!.character_info!,
                          primaryColor:
                              Color(state.data!.theme!.colors!.primary!),
                        ),
                        ViewOthersWidget(excludeId: state.data!.id),
                      ],
                    ),
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
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
