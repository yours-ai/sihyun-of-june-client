import 'package:flutter/material.dart';

class UpdateWidget extends StatelessWidget {
  const UpdateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('업데이트가 필요합니다.', style: TextStyle(fontFamily: 'MaruBuri')),
      content: Text('앱을 업데이트 해주세요.'),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text('확인'),
        ),
      ],
    );
  }
}
