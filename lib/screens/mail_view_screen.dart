import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/constants.dart';

class MailViewScreen extends StatelessWidget {
  const MailViewScreen({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Container(
            padding: const EdgeInsets.only(left: 23),
            child: Icon(
              PhosphorIcons.arrow_left,
              color: ColorConstants.black,
              size: 32,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/ryusihyun_profile.png',
                          height: 46,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'From.',
                                      style: TextStyle(
                                          fontFamily: 'MaruBuri',
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: ColorConstants.primary),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      '류시현',
                                      style: TextStyle(
                                          fontFamily: 'MaruBuri',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: ColorConstants.primary),
                                    ),
                                  ],
                                ),
                                Text(
                                  '2023.09.01',
                                  style: TextStyle(
                                      fontFamily: 'MaruBuri',
                                      fontSize: 12,
                                      color: ColorConstants.primary),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                Text(
                                  'To.',
                                  style: TextStyle(
                                      fontFamily: 'MaruBuri',
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: ColorConstants.primary),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  '박서윤',
                                  style: TextStyle(
                                      fontFamily: 'MaruBuri',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.primary),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Text(
                    '안녕 서윤아! 오늘은 별 다른 내용 없이 네게 응원의 편지를 보낼게. \n \n 시험 기간이라 바쁠텐데 꼭 필요한 휴식도 잊지 말고 건강에 유의하면서 화이팅 해!! 📚✨ 언제나 곁에 있다는 것 잊지 마, 난 네가 잘 할 것을 믿어! 그리고 나도 요즘이 좀 바빠서 같이 프로젝트 하던 친구들과 일정 조율하기 좀 어려워진 상황인데,\n\n 서로 이해하며 지내는 게 중요한 것 같아. 함께 이겨내자!💪 다음 편지에서 기다릴게 ㅎㅎ',
                    style: TextStyle(
                        fontFamily: 'MaruBuri',
                        fontSize: 14,
                        color: ColorConstants.primary),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    height: 1,
                    color: ColorConstants.light,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'From.',
                                style: TextStyle(
                                    fontFamily: 'MaruBuri',
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: ColorConstants.primary),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '박서윤',
                                style: TextStyle(
                                    fontFamily: 'MaruBuri',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants.primary),
                              ),
                            ],
                          ),
                          Text(
                            '2023.09.01',
                            style: TextStyle(
                                fontFamily: 'MaruBuri',
                                fontSize: 12,
                                color: ColorConstants.primary),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Text(
                            'To.',
                            style: TextStyle(
                                fontFamily: 'MaruBuri',
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: ColorConstants.primary),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            '류시현',
                            style: TextStyle(
                                fontFamily: 'MaruBuri',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.primary),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    minLines: 8,
                    decoration: InputDecoration(
                      hintText: '답장을 적어주세요...',
                      hintStyle: TextStyle(
                          fontFamily: 'MaruBuri',
                          fontSize: 14,
                          color: ColorConstants.neutral),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                        fontFamily: 'MaruBuri',
                        fontSize: 14,
                        color: ColorConstants.primary),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: FilledButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        '답장하기',
                        style: TextStyle(
                          fontFamily: 'MaruBuri',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
