import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_june_client/screens/splash_screen.dart';

final helloWorldProvider = Provider((_) => 'Hello world');

void main() {
  runApp(const ProviderScope(child: ProjectJuneApp()));
}

class ProjectJuneApp extends StatelessWidget {
  const ProjectJuneApp({super.key});

  @override
  Widget build(context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF036039),
        scaffoldBackgroundColor: Color(0xFFFCFCFC),
      ),
      title: 'Project June',
      home: SplashScreen(),
    );
  }
}
