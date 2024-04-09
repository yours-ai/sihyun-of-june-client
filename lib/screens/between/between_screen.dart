import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/screens/between/between_widget.dart';
import 'package:project_june_client/widgets/mail_list/empty_character.dart';

class BetweenScreen extends ConsumerWidget {
  const BetweenScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCharacter = ref.watch(selectedCharacterProvider);
    return Stack(
      children: [
        if (selectedCharacter != null)
          BetweenWidget(selectedCharacter)
        else
          const EmptyCharacterWidget('서로에 대해'),
      ],
    );
  }
}
