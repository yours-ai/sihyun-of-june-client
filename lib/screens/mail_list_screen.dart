import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/MailWidget.dart';

class MailListScreen extends HookWidget {
  MailListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _mailNum = useState(0);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(height: 60.0),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text('받은 편지함',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: Image.asset(
                  'assets/images/ryusihyun_profile.png',
                  height: 35,
                ),
              ),
            ]),
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
                        color: ColorConstants.neutral,
                        fontSize: 15,
                        height: 1.5),
                  )
                ],
              ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100.0,
        child: BottomNavigationBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          showSelectedLabels: false, // 선택된 아이템의 라벨을 숨김
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(PhosphorIcons.envelope_simple, size: 32),
              activeIcon: Icon(
                PhosphorIcons.envelope_simple_fill,
                color: ColorConstants.primary,
                size: 32,
              ),
              label: 'envelope',
            ),
            BottomNavigationBarItem(
              icon: const Icon(PhosphorIcons.bell, size: 32),
              activeIcon: Icon(PhosphorIcons.bell_fill,
                  color: Theme.of(context).primaryColor, size: 32),
              label: 'envelope',
            ),
            BottomNavigationBarItem(
              icon: const Icon(PhosphorIcons.list, size: 32),
              activeIcon: Icon(PhosphorIcons.list_bold,
                  color: Theme.of(context).primaryColor, size: 32),
              label: 'envelope',
            ),
          ],
        ),
      ),
    );
  }
}
