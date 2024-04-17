import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:project_june_client/constants.dart';

class HomeTodayWidget extends StatelessWidget {
  final String text;
  final String imageSrc;
  final String? buttonText;
  final VoidCallback? onPressed;
  final Color buttonColor;

  const HomeTodayWidget({
    super.key,
    required this.text,
    required this.imageSrc,
    this.buttonText,
    this.onPressed,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 70, 0, 20),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'NanumJungHagSaeng',
              color: ColorConstants.primary,
              fontSize: 35,
              height: 1,
              letterSpacing: 2,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          child: ExtendedImage.asset(
            imageSrc,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 30),
        if (buttonText != null)
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: buttonColor,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              buttonText!,
              style: TextStyle(
                fontFamily: 'Pretendard',
                color: ColorConstants.background,
                fontSize: 16,
                fontWeight: FontWeightConstants.semiBold,
              ),
            ),
          ),
      ],
    );
  }
}
