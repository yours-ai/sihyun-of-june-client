import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_june_client/screens/landing_screen.dart';

final helloWorldProvider = Provider((_) => 'Hello world');

void main() {
  runApp(const ProviderScope(child: ProjectJuneApp()));
}

class ProjectJuneApp extends StatelessWidget {
  const ProjectJuneApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      title: '유월의 시현이',
      home: LandingScreen(),
      theme: ThemeData(
        fontFamily: 'MaruBuri',
        brightness: Brightness.light,
        primaryColor: const Color(0xff1A1A1A),
        scaffoldBackgroundColor: const Color(0xfff6f6f6),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
