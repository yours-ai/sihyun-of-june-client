import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_june_client/screens/landing_screen.dart';

import 'constants.dart';

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
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: ColorConstants.primary,
          onPrimary: ColorConstants.white,
          secondary: ColorConstants.secondary,
          onSecondary: ColorConstants.white,
          error: ColorConstants.alert,
          onError: ColorConstants.white,
          background: ColorConstants.background,
          onBackground: ColorConstants.primary,
          surface: ColorConstants.background,
          onSurface: ColorConstants.primary,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            padding: EdgeInsets.symmetric(
              vertical: 17.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
