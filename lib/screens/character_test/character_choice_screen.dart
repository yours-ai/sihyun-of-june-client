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

  int testId = 0;
  String name = '시현';

  void handleActiveScreen(ActiveScreen screen) {
    setState(() {
      activeScreen = screen;
    });
  }

  void handleTestReason(TestReason reason) {
    setState(() {
      testReason = reason;
    });
  }

  void handleTestId(int id) {
    setState(() {
      testId = id;
    });
  }

  void handleName(String name) {
    setState(() {
      this.name = name;
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
            onActiveScreen: handleActiveScreen,
            onTestReason: handleTestReason,
            onTestId: handleTestId,
            onName: handleName);
      case ActiveScreen.confirm:
        return CharacterConfirmWidget(
            onActiveScreen: handleActiveScreen,
            testReason: testReason,
            testId: testId,
            name: name);
      default:
        return Container(); // Default empty container
    }
  }
}
