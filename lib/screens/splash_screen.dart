import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project_june_client/screens/login_screen.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(context) {
    useEffect(() {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: const LoginScreen(),
          ),
        );
      });
    }, []);

    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.png',
              width: 300,
            ),
          ],
        ),
      ),
    );
  }
}
