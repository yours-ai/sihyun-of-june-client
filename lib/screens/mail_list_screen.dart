import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/widgets/mail_widget.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/modal_widget.dart';

import '../constants.dart';

class MailListScreen extends StatefulWidget {
  const MailListScreen({super.key});

  @override
  State<MailListScreen> createState() => _MailListScreenState();
}

class _MailListScreenState extends State<MailListScreen> {
  final int _mailNum = 9;
  final bool _agreeLetter = false;

  @override
  initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _showModal();
  }


  _showModal() async {
    if (_agreeLetter == false) {
      await showModalBottomSheet<void>(
        context: context,
        useRootNavigator: true,
        builder: (BuildContext context) {
          return ModalWidget(
            title: '편지를 받으려면,\n알림 동의가 필요해요',
            choiceColumn: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FilledButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorConstants.background),
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(
                    '취소',
                    style: TextStyle(
                        fontSize: 14.0, color: ColorConstants.secondary),
                  ),
                ),
                FilledButton(
                  onPressed: () => context.go('/landing'),
                  child: const Text(
                    '동의하기',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(context) {
    return SafeArea(
      child: TitleLayout(
        showProfile: Padding(
          padding: const EdgeInsets.only(right: 28.0),
          child: TextButton(
            onPressed: () => context.push('/profile'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                'assets/images/ryusihyun_profile.png',
                height: 35,
              ),
            ),
          ),
        ),
        titleText: '받은 편지함',
        body: ListView(children: [
          if (_mailNum != 0)
            GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1.0,
                children: [
                  const MailWidget(isRead: 'false', date: "9.10"),
                  const MailWidget(isRead: 'true', date: "9.09"),
                  const MailWidget(isRead: 'true', date: "9.08"),
                  const MailWidget(isRead: 'true', date: "9.07"),
                  const MailWidget(isRead: 'true', date: "9.06"),
                  const MailWidget(isRead: 'true', date: "9.05"),
                  const MailWidget(isRead: 'true', date: "9.04"),
                  const MailWidget(isRead: 'true', date: "9.03"),
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
