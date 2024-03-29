import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/screens/between/between_widget.dart';
import 'package:project_june_client/screens/home/home_widget.dart';
import 'package:project_june_client/widgets/mail_list/empty_character.dart';

class BetweenScreen extends ConsumerStatefulWidget {
  const BetweenScreen({super.key});

  @override
  BetweenScreenState createState() => BetweenScreenState();
}

class BetweenScreenState extends ConsumerState<BetweenScreen> {
  bool? hasCharacter;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final myCharactersRawData = await fetchMyCharacterQuery().result;
      setState(() {
        hasCharacter = !(myCharactersRawData.data == null ||
            myCharactersRawData.data!.isEmpty);
      });
    });
  }

  @override
  Widget build(context) {
    if (hasCharacter == null) {
      return const SafeArea(
        child: Center(child: CircularProgressIndicator.adaptive()),
      );
    }
    return Stack(
      children: [
        if (hasCharacter!)
          const BetweenWidget()
        else
          const EmptyCharacterWidget('서로에 대해'),
      ],
    );
  }
}
