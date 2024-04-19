import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/models/character/character_colors.dart';
import 'package:project_june_client/actions/mails/models/mail_ticket_info.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/services.dart';

import '../../actions/mails/models/mail_in_list.dart';

enum MailState { notArrived, notReplied, replied }

class MailWidget extends StatelessWidget {
  MailInList? mail;
  bool hasPermission;
  final int mailIndex;
  final DateTime firstMailDate;
  final bool isFuture;
  final CharacterColors characterColors;
  final MailTicketInfo mailTicketInfo;
  final int assignId;

  MailWidget({
    super.key,
    this.mail,
    this.hasPermission = false,
    required this.mailIndex,
    required this.firstMailDate,
    required this.isFuture,
    required this.characterColors,
    required this.mailTicketInfo,
    required this.assignId,
  });

  Widget getLetterIcon(
      MailState mailState, int primaryColor, int secondaryColor) {
    final backgroundColorHex =
        commonService.intToHex(ColorConstants.background.value);
    late final String characterLetterColorHex;
    late final String userLetterColorHex;
    late final String letterBoxColorHex;
    if (mailState == MailState.notArrived) {
      characterLetterColorHex = backgroundColorHex;
      userLetterColorHex = backgroundColorHex;
      letterBoxColorHex = backgroundColorHex;
    } else {
      characterLetterColorHex = commonService.intToHex(primaryColor);
      userLetterColorHex = commonService.intToHex(secondaryColor);
      letterBoxColorHex = '#EBEBEB';
    }

    final svgString = '''
<svg width="37" height="41" viewBox="0 0 37 41" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect width="15.9884" height="28.0923" rx="0.153064" transform="matrix(0.882948 -0.469472 0.471167 0.882044 0.41539 10.3062)" fill="$characterLetterColorHex"/> ${mailState == MailState.notReplied ? "" : "<rect width='15.8444' height='28.0923' rx='0.153064' transform='matrix(0.913545 0.406737 -0.408331 0.912834 21.9408 0.650391)' fill='$userLetterColorHex'/>"}
  <path d="M34.3627 18.0534L3.58369 22.4005L3.58368 22.4005C3.35386 22.433 3.23895 22.4492 3.17058 22.5086C3.11327 22.5585 3.07653 22.6279 3.0675 22.7033C3.05674 22.7932 3.10788 22.8974 3.21017 23.1057L9.63717 36.1962C9.68397 36.2915 9.70736 36.3392 9.74245 36.3747C9.7722 36.4048 9.80787 36.4284 9.8472 36.444C9.89359 36.4624 9.9466 36.4653 10.0526 36.4711L26.9938 37.3988C27.1218 37.4058 27.1858 37.4093 27.2414 37.3906C27.2885 37.3748 27.331 37.3477 27.3653 37.3118C27.4059 37.2694 27.4298 37.2099 27.4778 37.0911L34.8887 18.7259C34.9947 18.4632 35.0477 18.3319 35.0221 18.234C35.0007 18.1522 34.9465 18.0829 34.8723 18.0424C34.7833 17.994 34.6431 18.0138 34.3627 18.0534Z" fill='$letterBoxColorHex'/>
</svg>
''';
    return SvgPicture.string(svgString, width: 35);
  }

  MailState checkMailState(MailInList? mail) {
    if (mail == null) {
      return MailState.notArrived;
    }
    if (mail.replies!.isEmpty) {
      return MailState.notReplied;
    } else {
      return MailState.replied;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mailState = checkMailState(mail);

    return GestureDetector(
      onTap: () {
        if (!isFuture) {
          if (mailState == MailState.notArrived) {
            transactionService.showEmptyMailModal(context);
          } else {
            if (hasPermission) {
              context.push('${RoutePaths.mailListMailDetail}/${mail!.id}');
            } else {
              transactionService.showBuyBothTicketModal(
                context: context,
                mailTicketInfo: mailTicketInfo,
                characterColors: characterColors,
                mailId: mail!.id,
                assignId: assignId,
              );
            }
          }
        } else if (!hasPermission) {
          transactionService.showBuyMonthlyTicketModal(
              context: context,
              mailTicketInfo: mailTicketInfo,
              characterColors: characterColors,
              assignId: assignId);
        }
      },
      child: Column(
        children: [
          Stack(
            children: [
              Center(
                child: Opacity(
                  opacity: (!hasPermission) ? 0.5 : 1,
                  child: getLetterIcon(
                    mailState,
                    characterColors.primary,
                    characterColors.secondary,
                  ),
                ),
              ),
              if (!hasPermission)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Icon(
                      PhosphorIcons.lock_simple_fill,
                      color: Color(0xffebebeb),
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 1),
          Text(
            mailService.getMailReceiveDateStr(
                firstMailDate.add(Duration(days: mailIndex)),
                (mailIndex) % 30 == 0),
            textScaler: TextScaler.noScaling,
            style: const TextStyle(
              fontSize: 11,
              fontFamily: 'GowunDodum',
            ),
          )
        ],
      ),
    );
  }
}
