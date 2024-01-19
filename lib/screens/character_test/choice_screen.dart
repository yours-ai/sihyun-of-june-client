import 'package:flutter/material.dart';

import '../../widgets/test/confirm_widget.dart';
import '../../widgets/test/character_detail_widget.dart';

enum ActiveScreen { detail, confirm }

enum TestReason { newUser, retest }

class TestChoiceScreen extends StatefulWidget {
  const TestChoiceScreen({super.key});

  @override
  _TestChoiceScreenState createState() => _TestChoiceScreenState();
}

class _TestChoiceScreenState extends State<TestChoiceScreen> {
  ActiveScreen activeScreen = ActiveScreen.detail;
  late TestReason testReason;

  int? testId;
  String? characterFirstName;
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
      characterFirstName = firstName;
      selectedCharacterId = characterId;
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
        return TestCharacterDetailWidget(
            onActiveScreen: handleActiveScreen, onTestInfo: handleTestInfo);
      case ActiveScreen.confirm:
        return TestConfirmWidget(
          selectedCharacterId: selectedCharacterId!,
          onActiveScreen: handleActiveScreen,
          testReason: testReason,
          testId: testId!,
          characterFirstName: characterFirstName!,
        );
      default:
        return Container(); // Default empty container
    }
  }
}
