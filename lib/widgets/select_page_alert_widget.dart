import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants.dart';
import '../providers/character_provider.dart';
import '../services.dart';
import 'common/alert/alert_widget.dart';

class SelectPageWidget extends ConsumerWidget {
  int? selectedPage;
  int mailReceivedMonth;
  final Function changeSelectedPage;

  SelectPageWidget(
      {super.key,
      required this.selectedPage,
      required this.mailReceivedMonth,
      required this.changeSelectedPage});

  Future showSelectPageAlert(
      int mailReceivedMonth, BuildContext context, WidgetRef ref) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertWidget(
            content: SizedBox(
              width: 300,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: mailReceivedMonth,
                itemBuilder: (context, index) {
                  return FilledButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.only(bottom: 3)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        selectedPage == index + 1
                            ? Color(ref
                                .watch(characterThemeProvider)
                                .colors!
                                .primary!)
                            : ColorConstants.veryLightGray,
                      ),
                    ),
                    onPressed: () async {
                      changeSelectedPage(index + 1);
                      context.pop();
                    },
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        mailService.makePageLabel(index + 1),
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'NanumJungHagSaeng',
                            color: selectedPage == index + 1
                                ? ColorConstants.background
                                : ColorConstants.neutral),
                      ),
                    ),
                  );
                },
              ),
            ),
            confirmText: '확인');
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => showSelectPageAlert(mailReceivedMonth, context, ref),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mailService.makePageLabel(selectedPage!),
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'NanumJungHagSaeng',
                color: ColorConstants.primary,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, top: 5),
              child: Icon(PhosphorIcons.caret_down_bold, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}
