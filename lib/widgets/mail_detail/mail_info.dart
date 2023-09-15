import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../services.dart';

class MailInfoWidget extends StatelessWidget {
  final String? byImage;
  final String toFullName;
  final String byFullName;
  final DateTime availableAt;

  const MailInfoWidget({
    Key? key,
    this.byImage,
    required this.toFullName,
    required this.byFullName,
    required this.availableAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (byImage != null) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
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
        )],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'From.',
                        style: TextStyle(
                            fontFamily: 'MaruBuri',
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: ColorConstants.primary),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        byFullName,
                        style: TextStyle(
                            fontFamily: 'MaruBuri',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.primary),
                      ),
                    ],
                  ),
                  Text(
                    mailService.formatMailDate(availableAt),
                    style: TextStyle(
                        fontFamily: 'MaruBuri',
                        fontSize: 12,
                        color: ColorConstants.primary),
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Text(
                    'To.',
                    style: TextStyle(
                        fontFamily: 'MaruBuri',
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: ColorConstants.primary),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    toFullName,
                    style: TextStyle(
                        fontFamily: 'MaruBuri',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.primary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
