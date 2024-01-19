import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/mail_list/overlay_component_widget.dart';

class TutorialOverlayWidget extends ConsumerStatefulWidget {
  final VoidCallback hideOverlay;
  final Offset offset;
  final AnimationController tutorialController;

  const TutorialOverlayWidget({
    super.key,
    required this.hideOverlay,
    required this.offset,
    required this.tutorialController,
  });

  @override
  ChangeCharacterOverlayWidgetState createState() =>
      ChangeCharacterOverlayWidgetState();
}

class ChangeCharacterOverlayWidgetState
    extends ConsumerState<TutorialOverlayWidget> {
  Animation<double>? tutorialFadeAnimation;

  @override
  void initState() {
    super.initState();
    tutorialFadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(widget.tutorialController);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.hideOverlay();
      },
      child: FadeTransition(
        opacity: tutorialFadeAnimation!,
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
                  child: Text('nothing'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
