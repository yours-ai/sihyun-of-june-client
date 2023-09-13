import 'package:flutter/material.dart';
import '../widgets/choice/character_confirm_widget.dart';
import '../widgets/choice/character_detail_widget.dart';
enum ActiveScreen { detail, confirm }

class CharacterChoiceScreen extends StatefulWidget {
  @override
  _CharacterChoiceScreen createState() => _CharacterChoiceScreen();
}

class _CharacterChoiceScreen extends State<CharacterChoiceScreen> {
  ActiveScreen activeScreen = ActiveScreen.detail;
  int test_id = 0;
  String name = '시현';

  void _setActiveScreen(ActiveScreen screen) {
    setState(() {
      activeScreen = screen;
    });
  }

  void _setTestId(int id) {
    setState(() {
      test_id = id;
    });
  }

  void _setName(String name) {
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
        return CharacterDetailWidget(setActiveScreen: _setActiveScreen, setTestId: _setTestId, setName: _setName);
      case ActiveScreen.confirm:
        return CharacterConfirmWidget(setActiveScreen: _setActiveScreen, test_id: test_id, name: name);
      default:
        return Container();  // Default empty container
    }
  }
}
