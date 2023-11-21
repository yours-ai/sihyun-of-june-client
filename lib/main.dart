import 'package:amplitude_flutter/amplitude.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:cached_storage/cached_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:project_june_client/actions/character/models/CharacterColors.dart';
import 'package:project_june_client/actions/character/models/CharacterTheme.dart';
import 'package:project_june_client/actions/client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'firebase_options.dart';

import 'constants.dart';
import 'environments.dart';
import 'globals.dart';
import 'router.dart';

void _appRunner() {
  return runApp(const ProviderScope(child: ProjectJuneApp()));
}

Future<void> _initialize() async {
  CachedQuery.instance.configFlutter(
    config: QueryConfigFlutter(
      refetchOnConnection: true,
      refetchOnResume: true,
    ),
    storage: await CachedStorage.ensureInitialized(),
  );
  assertBuildTimeEnvironments();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  KakaoSdk.init(
    nativeAppKey: BuildTimeEnvironments.kakaoNativeAppKey,
    javaScriptAppKey: BuildTimeEnvironments.kakaoJavascriptKey,
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Moment.setGlobalLocalization(MomentLocalizations.koKr());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: ColorConstants.background,
    // navigation bar color
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent, // status bar color
  ));
  if (BuildTimeEnvironments.amplitudeApiKey.isNotEmpty) {
    final Amplitude amplitude = Amplitude.getInstance();
    amplitude.init(BuildTimeEnvironments.amplitudeApiKey);
  } else {
    print("amplitude api key가 제공되지 않아, amplitude를 init하지 않습니다.");
  }
}

void main() async {
  await _initialize();
  if (BuildTimeEnvironments.sentryDsn.isEmpty) {
    print("sentry dsn이 제공되지 않아, sentry를 init하지 않습니다.");
    return _appRunner();
  }
  await SentryFlutter.init(
    (options) {
      options.dsn = BuildTimeEnvironments.sentryDsn;
      options.environment = BuildTimeEnvironments.sentryEnvironment;
      options.tracesSampleRate = 1.0;
    },
    appRunner: _appRunner,
  );
}

final deepLinkProvider = StateProvider<DeepLink?>((ref) => null);

final imageCacheDurationProvider = Provider<Duration>((ref) {
  return const Duration(minutes: 50);
});

final topPaddingProvider = StateProvider<double?>((ref) => null);

final characterThemeProvider = StateProvider.autoDispose<CharacterTheme>((ref) {
  final CharacterTheme defaultTheme = CharacterTheme(
    colors: CharacterColors(primary: 4294923379, secondary: 4294932624),
    font: "NanumNoRyeogHaNeunDongHee",
  );
  return defaultTheme;
});

class ProjectJuneApp extends ConsumerStatefulWidget {
  const ProjectJuneApp({super.key});

  @override
  ProjectJuneAppState createState() => ProjectJuneAppState();
}

class ProjectJuneAppState extends ConsumerState<ProjectJuneApp> {
  @override
  void initState() {
    super.initState();
    initServerErrorSnackbar(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final topPadding = MediaQuery.of(context).padding.top;
      ref.read(topPaddingProvider.notifier).state = topPadding;
    });
  }

  @override
  Widget build(context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: '유월의 시현이',
      routerConfig: router,
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: ThemeData(
        fontFamily: 'Pretendard',
        scaffoldBackgroundColor: ColorConstants.background,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: ColorConstants.primary,
          onPrimary: ColorConstants.background,
          secondary: ColorConstants.lightPink,
          onSecondary: ColorConstants.white,
          error: ColorConstants.alert,
          onError: ColorConstants.white,
          background: ColorConstants.background,
          onBackground: ColorConstants.neutral,
          surface: ColorConstants.background,
          onSurface: ColorConstants.neutral,
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        textTheme: TextTheme(
          titleLarge: TextStyle(
              fontFamily: 'NanumJungHagSaeng',
              fontSize: 39,
              height: 36 / 39,
              color: ColorConstants.primary),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            textStyle: TextStyle(
              fontWeight: FontWeightConstants.semiBold,
            ),
            backgroundColor:
                Color(ref.watch(characterThemeProvider).colors!.primary!),
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.symmetric(
              vertical: 17.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: FilledButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.symmetric(
              vertical: 17.0,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            side: BorderSide(
              color: ColorConstants.neutral,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 17.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: ColorConstants.background,
          elevation: 0,
          unselectedItemColor: ColorConstants.primary,
        ),
        cardTheme: CardTheme(
          elevation: 0,
          color: ColorConstants.background,
        ),
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 26,
            vertical: 8,
          ),
        ),
      ),
      scrollBehavior: SplashScrollBehavior(
          ref.watch(characterThemeProvider).colors!.primary!),
    );
  }
}

class SplashScrollBehavior extends MaterialScrollBehavior {
  final int splashColor;

  const SplashScrollBehavior(this.splashColor);

  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return GlowingOverscrollIndicator(
      axisDirection: details.direction,
      color: Color(splashColor),
      child: child,
    );
  }
}
