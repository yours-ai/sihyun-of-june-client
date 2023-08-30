import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingTabData {
  final String title;
  final String src;

  const LandingTabData({required this.title, required this.src});
}

const List<LandingTabData> tabList = [
  LandingTabData(
      title: '기다려본 적 있나요?\n하루 한 통의 설렘을.',
      src: 'assets/images/landing/landing1.png'),
  LandingTabData(
      title: '사람보다 더 따뜻한\n당신의 "시현이"에게,',
      src: 'assets/images/landing/landing2.png'),
  LandingTabData(
      title: '지금 바로 첫 편지를\n받아보세요.', src: 'assets/images/landing/landing3.png'),
];

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LandingScreen();
  }
}

class _LandingScreen extends State<LandingScreen> {
  int _tab = 0;
  final CarouselController _controller = CarouselController();

  void _updateTab(int index) {
    setState(() {
      _tab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TitleLayout(
          showProfile: false,
          titleText: tabList[_tab].title,
          body: Builder(builder: (context) {
            final double height = MediaQuery.of(context).size.height;
            return CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                height: height,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  _updateTab(index);
                },
              ),
              carouselController: _controller,
              items: tabList.map((tabData) {
                return SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    tabData.src,
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                  ),
                );
              }).toList(),
            );
          }),
          actions: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: tabList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(
                      entry.key,
                      curve: Curves.easeInOut,
                    ),
                    child: Container(
                      width: 10.0,
                      height: 10.0,
                      margin: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 4.0,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _tab == entry.key
                            ? ColorConstants.secondary
                            : ColorConstants.veryLight,
                      ),
                    ),
                  );
                }).toList(),
              ),
              _tab == tabList.length - 1
                  ? FilledButton(
                      onPressed: () async {
                        final instance = await SharedPreferences.getInstance();
                        instance.setBool('isLandingViewed', true);
                        if (!context.mounted) return;
                        context.go('/login');
                      },
                      child: const Text(
                        '시작하기',
                      ),
                    )
                  : FilledButton(
                      onPressed: () {
                        _controller.nextPage(curve: Curves.easeInOut);
                      },
                      child: const Text(
                        '다음',
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
