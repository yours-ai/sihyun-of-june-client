import 'package:flutter/material.dart';

import '../../widgets/character/character_confirm_widget.dart';
import '../../widgets/character/character_detail_widget.dart';

enum ActiveScreen { detail, confirm }

enum TestReason { newUser, retest }

class CharacterChoiceScreen extends StatefulWidget {
  const CharacterChoiceScreen({super.key});

  @override
  _CharacterChoiceScreen createState() => _CharacterChoiceScreen();
}

class _CharacterChoiceScreen extends State<CharacterChoiceScreen> {
  ActiveScreen activeScreen = ActiveScreen.detail;
  late TestReason testReason;

  int? testId;
  String? name;
  int? selectedCharacterId;

  void handleActiveScreen(ActiveScreen screen) {
    setState(() {
      activeScreen = screen;
    });
  }

  void handleTestInfo(
      {required TestReason reason,
      required int testId,
      required String firstName,
      required int characterId}) {
    setState(() {
      testReason = reason;
      this.testId = testId;
      this.name = firstName;
      this.selectedCharacterId = characterId;
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _getActiveScreenContent(),
      ),
    );
  }

  Widget _getActiveScreenContent() {
    switch (activeScreen) {
      case ActiveScreen.detail:
        return CharacterDetailWidget(
            onActiveScreen: handleActiveScreen, onTestInfo: handleTestInfo);
      case ActiveScreen.confirm:
        return CharacterConfirmWidget(
            selectedCharacterId: selectedCharacterId!,
            onActiveScreen: handleActiveScreen,
            testReason: testReason,
            testId: testId!,
            name: name!);
      default:
        return Container(); // Default empty container
    }
  }
}
