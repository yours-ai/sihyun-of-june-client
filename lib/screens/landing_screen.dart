import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final List<String> imgList = [
  'assets/images/landing/landing1.png',
  'assets/images/landing/landing2.png',
  'assets/images/landing/landing3.png',
];

class LandingScreen extends HookWidget {
  LandingScreen({Key? key}) : super(key: key);

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final tab = useState<int>(0);
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50),
              Expanded(child: Builder(builder: (context) {
                final double height = MediaQuery.of(context).size.height;
                return CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1,
                    height: height,
                    onPageChanged: (index, reason) {
                      tab.value = index;
                    },
                  ),
                  carouselController: _controller,
                  items: imgList.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Text(
                                  '기다려본 적 있나요?\n하루 한 통의 설렘을.',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              SizedBox(height: 30),
                              Expanded(
                                child: Image.asset(i),
                              ),
                            ]);
                      },
                    );
                  }).toList(),
                );
              })),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                              .withOpacity(tab.value == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 20.0,
                    top: 30.0,
                  ),
                  child: FilledButton(
                    onPressed: () {},
                    child: Text(
                      '다음',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
