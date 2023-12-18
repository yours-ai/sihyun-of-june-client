import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';

import '../../constants.dart';

class RetestLayoutWidget extends StatelessWidget {
  final String firstName;
  final String title;
  final Widget body;
  final Widget action;

  const RetestLayoutWidget(
      {super.key,
      required this.firstName,
      required this.title,
      this.body = const SizedBox.shrink(),
      required this.action});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorConstants.background,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Container(
              padding: const EdgeInsets.only(left: 15),
              child: Icon(
                PhosphorIcons.arrow_left,
                color: ColorConstants.gray,
                size: 32,
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: Text(
                '${firstName}이와의 30일이 모두 끝났어요.',
                style: TextStyle(
                  fontSize: 16,
                  color: ColorConstants.neutral,
                  fontFamily: 'Pretendard',
                ),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          actions: const <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: SizedBox(width: 32),
            )
          ],
        ),
        body: SafeArea(
          child: TitleLayout(
            withAppBar: true,
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
            body: body,
            actions: action,
          ),
        ));
  }
}
