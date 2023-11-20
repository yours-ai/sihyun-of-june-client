import 'package:flutter/material.dart';
import 'package:project_june_client/actions/character/dtos.dart';
import 'package:project_june_client/widgets/test/in_test_widget.dart';
import 'package:project_june_client/widgets/test/test_start_widget.dart';
import 'package:project_june_client/widgets/test/test_result_widget.dart';

enum ActiveScreen { start, inTest, result }

class CharacterTestScreen extends StatefulWidget {
  const CharacterTestScreen({super.key});

  @override
  State<CharacterTestScreen> createState() => _CharacterTestScreenState();
}

class _CharacterTestScreenState extends State<CharacterTestScreen> {
  ActiveScreen activeScreen = ActiveScreen.start;
  AnswerDTOList responses = AnswerDTOList(answers: []);

  void handleActiveScreen(ActiveScreen screen) {
    setState(() {
      activeScreen = screen;
    });
  }

  void _responses(AnswerDTOList answerDTOList) {
    setState(() {
      responses = answerDTOList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _getActiveScreenContent(),
      ),
    );
  }

  Widget _getActiveScreenContent() {
    switch (activeScreen) {
      case ActiveScreen.start:
        return TestStartWidget(onActiveScreen: handleActiveScreen);
      case ActiveScreen.inTest:
        return InTestWidget(
            onActiveScreen: handleActiveScreen, responses: _responses);
      case ActiveScreen.result:
        return TestResultWidget(responses: responses);
      default:
        return Container(); // Default empty container
    }
  }
}
