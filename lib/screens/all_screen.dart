import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/widgets/notification_widget.dart';

import '../constants.dart';
import '../contrib/flutter_hooks.dart';
import '../widgets/common/title_layout.dart';
import '../widgets/modal_widget.dart';

class AllScreen extends HookWidget {
  const AllScreen({super.key});

  @override
  Widget build(context) {
    final agreeLetter = useState(false);

    if(agreeLetter.value==false){
      useAsyncEffect(() async {
        final result = await showModalBottomSheet<void>(
          context: context,
          useRootNavigator: true,
          builder: (BuildContext context) {
            return ModalWidget(
              moreDescription: true,
              description: '친구에게 서비스를 소개하고,\n무료 코인을 받아보세요!',
              button1: '됐어요',
              button2: '친구에게 소개하고 50코인 받기',
              action: () => context.go('/landing'),
            );
          },
        );
      }, []);
    }

    return SafeArea(
        child: TitleLayout(
      showProfile: false,
      titleText: '전체',
      body: Column(
        children: [
          Container(
            color: ColorConstants.background,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                splashFactory: NoSplash.splashFactory,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 83,
                    padding: EdgeInsets.only(left: 28),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '내 코인',
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.black,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 28.0),
                    child: Container(
                        child: Row(
                      children: [
                        Text(
                          '80',
                          style: TextStyle(
                            fontSize: 18,
                            color: ColorConstants.neutral,
                          ),
                        ),
                        Icon(
                          PhosphorIcons.coin_vertical,
                          size: 20,
                          color: ColorConstants.neutral,
                        ),
                        Icon(
                          PhosphorIcons.caret_right,
                          size: 20,
                          color: ColorConstants.neutral,
                        ),
                      ],
                    )),
                  )
                ],
              ),
              onPressed: () {},
            ),
          ),
          Container(
            color: ColorConstants.background,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                splashFactory: NoSplash.splashFactory,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 83,
                    padding: EdgeInsets.only(left: 28),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '친구 초대하고, 50코인 받기',
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.black,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              onPressed: () {},
            ),
          ),
          Container(
            color: ColorConstants.background,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                splashFactory: NoSplash.splashFactory,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 83,
                    padding: EdgeInsets.only(left: 28),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '공지',
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.black,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              onPressed: () {},
            ),
          ),
          Container(
            color: ColorConstants.background,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                splashFactory: NoSplash.splashFactory,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 83,
                    padding: EdgeInsets.only(left: 28),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '자주 묻는 질문',
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.black,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              onPressed: () {},
            ),
          ),
          Container(
            color: ColorConstants.background,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                splashFactory: NoSplash.splashFactory,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 83,
                    padding: EdgeInsets.only(left: 28),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '문의하기',
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.black,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              onPressed: () {},
            ),
          ),
          Container(
            color: ColorConstants.background,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                splashFactory: NoSplash.splashFactory,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 83,
                    padding: EdgeInsets.only(left: 28),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '약관 및 정책 이해하기',
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.black,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    ));
  }
}
