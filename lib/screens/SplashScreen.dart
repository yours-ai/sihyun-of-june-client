import 'package:flutter/cupertino.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(context) {
    return CupertinoPageScaffold(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Splash Screen'),
          CupertinoButton.filled(
            onPressed: () {},
            child: Text('Login'),
          ),
          CupertinoButton.filled(
            onPressed: () {},
            child: Text('Home'),
          ),
        ],
      )),
    );
  }
}
