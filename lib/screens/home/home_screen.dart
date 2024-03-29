import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/screens/home/home_widget.dart';
import 'package:project_june_client/widgets/mail_list/empty_character.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
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
          const HomeWidget()
        else
          const EmptyCharacterWidget('HOME'),
      ],
    );
  }
}
