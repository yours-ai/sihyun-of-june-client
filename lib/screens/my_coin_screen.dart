import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/menu_widget.dart';

import '../constants.dart';

class MyCoinScreen extends StatelessWidget {
  const MyCoinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TitleLayout(
          titleText: '내 코인',
          titleAddOn: Row(
            children: [
              Text('80'),
              Icon(
                PhosphorIcons.coin_vertical,
                color: ColorConstants.black,
                size: 32,
              ),
            ],
          ),
          body: Column(
            children: [
              MenuWidget(
                title: '1,100원',
                onPressed: () {},
                suffix: Row(
                  children: [
                    Text('10'),
                    Icon(
                      PhosphorIcons.coin_vertical,
                      color: ColorConstants.black,
                      size: 32,
                    ),
                  ],
                ),
              ),
              MenuWidget(title: '5,500원', onPressed: () {}),
              MenuWidget(title: '11,000원', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
