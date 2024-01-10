import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';

class EmptyMailListWidget extends StatelessWidget {
  const EmptyMailListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TitleLayout(
        title: const Center(
          child: TitleUnderline(
            titleText: '받은 편지함',
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '아직 배정받지\n않으셨군요!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorConstants.primary,
                    fontSize: 21,
                    height: 1,
                    fontWeight: FontWeightConstants.semiBold,
                  ),
                ),
                const SizedBox(height: 40),
                FilledButton(
                  onPressed: () {},
                  child: const Text('배정 받기'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
