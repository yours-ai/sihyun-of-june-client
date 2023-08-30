import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/contrib/flutter_hooks.dart';
import 'package:project_june_client/widgets/mail_widget.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/modal_widget.dart';

import '../constants.dart';

class MailListScreen extends HookWidget {
  const MailListScreen({super.key});

  @override
  Widget build(context) {
    final _mailNum = useState(9);
    final _agreeLetter = useState(false);

    if(_agreeLetter==false){
      useAsyncEffect(() async {
        final result = await showModalBottomSheet<void>(
          context: context,
          useRootNavigator: true,
          builder: (BuildContext context) {
            return ModalWidget(
              description: '편지를 받으려면,\n알림 동의가 필요해요',
              button1: '취소',
              button2: '동의하기',
              action: () => context.go('/landing'),
            );
          },
        );
      }, []);
    }
    return SafeArea(
      child: TitleLayout(
        showProfile: true,
        titleText: '받은 편지함',
        body: ListView(children: [
          if (_mailNum.value != 0)
            GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1.0,
                children: [
                  MailWidget(isRead: 'false', date: "9.10"),
                  MailWidget(isRead: 'true', date: "9.09"),
                  MailWidget(isRead: 'true', date: "9.08"),
                  MailWidget(isRead: 'true', date: "9.07"),
                  MailWidget(isRead: 'true', date: "9.06"),
                  MailWidget(isRead: 'true', date: "9.05"),
                  MailWidget(isRead: 'true', date: "9.04"),
                  MailWidget(isRead: 'true', date: "9.03"),
                ])
          else
            Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  '🍂',
                  style: TextStyle(fontSize: 100),
                ),
                const SizedBox(height: 20),
                Text(
                  '아직 도착한 편지가 없어요. \n 내일 9시에 첫 편지가 올 거에요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorConstants.neutral, fontSize: 15, height: 1.5),
                )
              ],
            ),
        ]),
      ),
    );
  }
}
