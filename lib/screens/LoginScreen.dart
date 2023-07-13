import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const exampleText = <(String, String)>[
  (
    "친구와 얘기하는거와는. 또 다른 느낌이였어요. 물론 엄청 편했구요. 고민 이야기도하고 일상적인 얘기도 하구 굉장히 힐링되고 즐거웠어요.",
    "김OO님, 시현이와 함께"
  ),
  (
    "친절하게 답장을 해주시는 것에 큰 감동을 받았고 이야기를 나누면 나눌수록 더욱 친밀감이 쌓이는 좋은 기회였어요.",
    "박OO님, 하준이와 함께"
  ),
];

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(context) {
    final index = useState(0);
    final visible = useState(true);
    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        visible.value = false;
        Timer(const Duration(seconds: 1), () {
          if (index.value == exampleText.length - 1) {
            index.value = 0;
          } else {
            index.value++;
          }
          visible.value = true;
        });
      });
      return () => timer.cancel();
    }, []);
    return CupertinoPageScaffold(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              CupertinoColors.black.withOpacity(0.5),
              BlendMode.darken,
            ),
            image: AssetImage("images/login/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              // Positioned at the top
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    '유월의 시현이 🪴',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              // Positioned in the middle
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '매일 한 통 씩 찾아오는 설렘.',
                        style: TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 20),
                      AnimatedOpacity(
                          opacity: visible.value ? 1.0 : 0.0,
                          duration: const Duration(seconds: 1),
                          // The green box must be a child of the AnimatedOpacity widget.
                          child: Column(
                            children: [
                              Text(
                                exampleText[index.value].$1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: CupertinoColors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                exampleText[index.value].$2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: CupertinoColors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              // Positioned at the bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CupertinoButton.filled(
                        child: const Text(
                          '시작하기',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
