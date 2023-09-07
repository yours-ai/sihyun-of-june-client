import 'package:flutter/material.dart';
import 'package:project_june_client/widgets/test/in_test_widget.dart';
import 'package:project_june_client/widgets/test/test_info_widget.dart';
import 'package:project_june_client/widgets/test/test_result_widget.dart';

enum ActiveScreen { info, inTest, result }

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  ActiveScreen activeScreen = ActiveScreen.result;
  List<List<num>> responses = [];

  void _setActiveScreen(ActiveScreen screen) {
    setState(() {
      activeScreen = screen;
    });
  }

  void _responses (List<List<num>> answer) {
    setState(() {
      responses = answer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: _getActiveScreenContent(),
      ),
    );
  }

  Widget _getActiveScreenContent() {
    switch (activeScreen) {
      case ActiveScreen.info:
        return TestInfoWidget(setActiveScreen: _setActiveScreen);
      case ActiveScreen.inTest:
        return InTestWidget(setActiveScreen: _setActiveScreen, responses: _responses);
      case ActiveScreen.result:
        return TestResultWidget(responses: responses);
      default:
        return Container();  // Default empty container
    }
  }
}