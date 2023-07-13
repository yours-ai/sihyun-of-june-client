import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(context) {
    useEffect(() {
      Future.delayed(const Duration(seconds: 1), () {
        context.go('/login');
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
