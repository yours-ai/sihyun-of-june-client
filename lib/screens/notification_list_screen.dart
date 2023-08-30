import 'package:flutter/material.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';

class NotificationListScreen extends StatelessWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(context) {
    return SafeArea(
        child: TitleLayout(
      showProfile: false,
      titleText: '알림',
      body: Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(

                  color: Color(0xFFECECEC),
                  padding: EdgeInsets.all(22),
                  child: Text(
                    '새로 추가된 공지사항을 확인해주세요.',
                    style: TextStyle(
                        fontSize: 15,
                        color: ColorConstants.secondary,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
