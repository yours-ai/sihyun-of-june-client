import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectTabdata {
  final String title;
  final Widget bodySrc;
  final String primaryChoice;
  final String secondaryChoice;

  const SelectTabdata(
      {required this.title,
      this.bodySrc = const SizedBox(),
      this.primaryChoice = '',
      this.secondaryChoice = ''});
}

final List<SelectTabdata> tabList = [
  SelectTabdata(
      title: '먼저, 서윤님과\n한달간 편지를 나눌\n상대를 정해드리려고 해요.',
      bodySrc:
          SizedBox(child: Image.asset('assets/images/landing/landing2.png')),
      primaryChoice: '그래요?'),
  const SelectTabdata(
      title: '간단한 질문들로,\n서윤님에 대해 알아볼게요.', primaryChoice: '알겠어요!'),
  const SelectTabdata(
      title: '서윤님은 어떤 영화를 \n더 좋아하세요?',
      primaryChoice: '잔잔한 로맨스 영화',
      secondaryChoice: '웅장한 블록버스터 영화'),
  const SelectTabdata(
      title: '서윤님이 스트레스를\n많이 받는 상황일 때,\n어떤 말을 듣고 싶으세요?',
      primaryChoice: '"어쩔 수 없지. 좀만 힘내"',
      secondaryChoice: '"ㅠㅠ 어떡해 내가 다 혼내줄게!"'),
  const SelectTabdata(
      title: '서윤님에게 조금 더\n가까운 것은 어디에요?\n방을 한 번 둘러봐요.',
      primaryChoice: '맥시멀리스트',
      secondaryChoice: '미니멀리스트'),
  const SelectTabdata(title: '상대가 정해졌어요!\n확인해보실래요?', primaryChoice: '두근두근...'),
];

class SelectScreen extends StatefulWidget {
  const SelectScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SelectScreen();
  }
}

class _SelectScreen extends State<SelectScreen> {
  int _tab = 0;
  final PageController _controller = PageController();

  void _updateTab(int index) {
    setState(() {
      _tab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: AppBar(
          backgroundColor: ColorConstants.background,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: LinearProgressIndicator(
              value: (_tab + - 2)  / (tabList.length - 3 ),
              backgroundColor: ColorConstants.background,
              valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.secondary),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: TitleLayout(
          titleText: tabList[_tab].title,
          body: Builder(builder: (context) {
            final double height = MediaQuery.of(context).size.height;
            return PageView(
              controller: _controller,
              onPageChanged: (index) {
                _updateTab(index);
              },
              children: [
                tabList[_tab].bodySrc,
              ],
            );
          }),
          actions: [tabList.length - 1, 0, 1].contains(_tab)
              ? _tab == tabList.length - 1 ?
          (FilledButton(
            onPressed: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              prefs.setBool('selectCharacter', true);
              context.go('/mails');
            },
            child: const Text(
              '시작하기',
            ),
          )):
           OutlinedButton(
                  onPressed: () {
                      setState(() {
                        _tab++;
                      });
                  },
                  child: Text(tabList[_tab].primaryChoice),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _tab++;
                        });
                      },
                      child: Text(tabList[_tab].primaryChoice),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _tab++;
                        });
                      },
                      child: Text(tabList[_tab].secondaryChoice),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
