import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/screens/home/home_widget.dart';
import 'package:project_june_client/widgets/mail_list/empty_character.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCharacter = ref.watch(selectedCharacterProvider);
    return Stack(
      children: [
        if (selectedCharacter != null)
          HomeWidget(selectedCharacter)
        else
          const EmptyCharacterWidget('HOME'),
      ],
    );
  }
}
