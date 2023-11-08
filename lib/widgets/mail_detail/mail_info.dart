import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../services.dart';

class MailInfoWidget extends StatelessWidget {
  final String? byImage;
  final String toFullName;
  final String byFullName;
  final DateTime availableAt;
  final bool isMe;

  const MailInfoWidget({
    Key? key,
    required this.byImage,
    required this.toFullName,
    required this.byFullName,
    required this.availableAt,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: isMe ? TextDirection.rtl : TextDirection.ltr,
      children: [
        if (byImage != null) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              loadingBuilder: (context, child, loadingProgress) {
                return SizedBox(
                  height: 46,
                  width: 46,
                  child: child,
                );
              },
              byImage!,
              height: 46,
            ),
          ),
          const SizedBox(
            width: 16,
          )
        ] else ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              'assets/images/default_user_image.png',
              height: 46,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
        Expanded(
          child: Row(
            textDirection: isMe ? TextDirection.rtl : TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: isMe? CrossAxisAlignment.end :CrossAxisAlignment.start,
                children: [
                  Text(
                    'From. $byFullName',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.gray),
                  ),
                  Text(
                    'To. $toFullName',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.pink),
                  ),
                ],
              ),
              Text(
                mailService.formatMailDate(availableAt),
                style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.gray),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
