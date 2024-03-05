import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/services.dart';

import '../../actions/mails/models/Mail.dart';

class MailWidget extends ConsumerWidget {
  final Mail? mail;
  final int? mailNumber;
  final DateTime? firstMailDate;

  const MailWidget(
      {super.key, this.mail, this.mailNumber = 0, this.firstMailDate});

  Widget letterIcon(
      String mailState, String primaryColor, String secondaryColor) {
    final svgString = '''
<svg width="37" height="41" viewBox="0 0 37 41" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect width="15.9884" height="28.0923" rx="0.153064" transform="matrix(0.882948 -0.469472 0.471167 0.882044 0.41539 10.3062)" 
  fill="${mailState == "notSent" ? "#EBEBEB" : primaryColor}"/>
  ${mailState == "notReplied" ? "" : "<rect width='15.8444' height='28.0923' rx='0.153064' transform='matrix(0.913545 0.406737 -0.408331 0.912834 21.9408 0.650391)' fill='${mailState == "notSent" ? "#F2F2F2" : secondaryColor}'/>"}
  <path d="M34.3627 18.0534L3.58369 22.4005L3.58368 22.4005C3.35386 22.433 3.23895 22.4492 3.17058 22.5086C3.11327 22.5585 3.07653 22.6279 3.0675 22.7033C3.05674 22.7932 3.10788 22.8974 3.21017 23.1057L9.63717 36.1962C9.68397 36.2915 9.70736 36.3392 9.74245 36.3747C9.7722 36.4048 9.80787 36.4284 9.8472 36.444C9.89359 36.4624 9.9466 36.4653 10.0526 36.4711L26.9938 37.3988C27.1218 37.4058 27.1858 37.4093 27.2414 37.3906C27.2885 37.3748 27.331 37.3477 27.3653 37.3118C27.4059 37.2694 27.4298 37.2099 27.4778 37.0911L34.8887 18.7259C34.9947 18.4632 35.0477 18.3319 35.0221 18.234C35.0007 18.1522 34.9465 18.0829 34.8723 18.0424C34.7833 17.994 34.6431 18.0138 34.3627 18.0534Z" 
  fill="#EBEBEB"/>
</svg>
''';
    return SvgPicture.string(svgString, width: 35);
  }

  @override
  Widget build(BuildContext context, ref) {
    final mailState = mail != null
        ? mail!.replies!.isEmpty
            ? 'notReplied'
            : 'replied'
        : 'notSent';

    return Container(
      child: mailState != 'notSent'
          ? GestureDetector(
              onTap: () {
                context.push('${RoutePaths.mailListMailDetail}/${mail!.id}');
              },
              child: Column(
                children: [
                  letterIcon(
                      mailState,
                      '#${ref.watch(characterThemeProvider).colors.primary.toRadixString(16).toString().substring(
                            2,
                          )}',
                      '#${ref.watch(characterThemeProvider).colors.secondary.toRadixString(16).toString().substring(
                            2,
                          )}'),
                  const SizedBox(height: 1),
                  Text(
                    mailService.getMailReceiveDateStr(
                        mail!.available_at, (mailNumber!) % 30 == 0),
                    style:
                        const TextStyle(fontSize: 11, fontFamily: 'GowunDodum'),
                  )
                ],
              ),
            )
          : Column(
              children: [
                letterIcon(
                    mailState,
                    '#${ref.watch(characterThemeProvider).colors.primary.toRadixString(16).toString().substring(
                          2,
                        )}',
                    '#${ref.watch(characterThemeProvider).colors.secondary.toRadixString(16).toString().substring(
                          2,
                        )}'),
                const SizedBox(height: 1),
                Text(
                  mailService.getMailReceiveDateStr(
                      firstMailDate!.add(Duration(days: mailNumber!)),
                      (mailNumber!) % 30 == 0),
                  style:
                      const TextStyle(fontSize: 11, fontFamily: 'GowunDodum'),
                ),
              ],
            ),
    );
  }
}
