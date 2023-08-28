import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'constants.dart';
import 'router.dart';

final helloWorldProvider = Provider((_) => 'Hello world');

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const ProviderScope(child: ProjectJuneApp()));
}

class ProjectJuneApp extends StatelessWidget {
  const ProjectJuneApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp.router(
      title: '유월의 시현이',
      routerConfig: router,
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
            padding: const EdgeInsets.symmetric(
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
