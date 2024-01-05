import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/mail_list/overlay_component_widget.dart';

class ChangeCharacterOverlayWidget extends ConsumerStatefulWidget {
  final VoidCallback hideOverlay;
  final Offset offset;
  final List<Character> characterList;
  final AnimationController profileChangeController;

  const ChangeCharacterOverlayWidget({
    super.key,
    required this.hideOverlay,
    required this.offset,
    required this.characterList,
    required this.profileChangeController,
  });

  @override
  ChangeCharacterOverlayWidgetState createState() =>
      ChangeCharacterOverlayWidgetState();
}

class ChangeCharacterOverlayWidgetState
    extends ConsumerState<ChangeCharacterOverlayWidget> {
  Animation<double>? profileChangeFadeAnimation;

  @override
  void initState() {
    super.initState();
    profileChangeFadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(widget.profileChangeController);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.hideOverlay();
      },
      child: FadeTransition(
        opacity: profileChangeFadeAnimation!,
        child: Material(
          color: Colors.black54,
          child: Stack(
            children: [
              Positioned(
                top: widget.offset.dy - 7,
                right:
                    MediaQuery.of(context).size.width - widget.offset.dx - 54,
                child: Container(
                  width: 180,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    children: [
                      ...widget.characterList
                          .where((character) =>
                              character.id ==
                              ref.watch(selectedCharacterProvider))
                          .map(
                            (character) => OverlayComponentWidget(
                              character: character,
                            ),
                          )
                          .toList(),
                      ...widget.characterList
                          .where((character) =>
                              character.id !=
                              ref.watch(selectedCharacterProvider))
                          .map(
                            (character) => OverlayComponentWidget(
                              character: character,
                              hideOverlay: widget.hideOverlay,
                            ),
                          )
                          .toList(),
                      OverlayComponentWidget(
                        hideOverlay: widget.hideOverlay,
                        firstName: characterService
                            .getCurrentCharacterFirstName(widget.characterList),
                        characterIds: characterService
                            .getCharacterIds(widget.characterList),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
