import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/constants.dart';

class MailWidget extends StatelessWidget {
  final String isRead, date;

  const MailWidget({super.key, required this.isRead, required this.date});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => context.push('/mails/view'),
        child: Stack(
        alignment: Alignment.center,
        children: [
          const SizedBox(
            height: 57,
            width: 50,
          ),
          Positioned(
            top: 0,
            child: Icon(
                isRead == 'true'
                    ? (PhosphorIcons.envelope_simple_open_thin)
                    : (PhosphorIcons.envelope_simple),
                color: isRead == 'true'
                    ? ColorConstants.neutral
                    : ColorConstants.primary,
                size: 50),
          ),
          Positioned(
            top: 43,
            child: Text(
              date,
              style: TextStyle(
                fontWeight:
                isRead == 'true' ? FontWeight.normal : FontWeight.bold,
                color: isRead == 'true'
                    ? ColorConstants.neutral
                    : ColorConstants.primary,
                fontSize: 10,
              ),
            ),
          ),
          isRead == 'true'
              ? const SizedBox(
            height: 0,
            width: 0,
          )
              : Positioned(
            top: 5,
            left: 39,
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: const Color(0xffFE3140),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    ),);
  }
}
