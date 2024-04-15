import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';

class EmptyCharacterWidget extends StatelessWidget {
  final String titleText;

  const EmptyCharacterWidget(this.titleText, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TitleLayout(
        title: Center(
          child: TitleUnderline(
            titleText: titleText,
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
                  '아직 편지를 주고받을\n상대가 없어요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorConstants.primary,
                    fontSize: 25,
                    height: 40 / 25,
                    fontWeight: FontWeightConstants.semiBold,
                  ),
                ),
                const SizedBox(height: 23),
                FilledButton(
                  onPressed: () {
                    context.go(RoutePaths.assignment);
                  },
                  child: const Text('새로운 상대 만나기'),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
