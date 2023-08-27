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
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xff1a1a1a),
          onPrimary: Color(0xffffffff),
          secondary: Color.fromRGBO(68, 68, 68, 0.9),
          onSecondary: Color(0xffffffff),
          error: Color.fromRGBO(254, 49, 64, 1),
          onError: Color(0xffffffff),
          background: Color(0xfff6f6f6),
          onBackground: Color(0xff1a1a1a),
          surface: Color(0xfff6f6f6),
          onSurface: Color(0xff1a1a1a),
        ),
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
