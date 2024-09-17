import 'package:flutter/material.dart';
import 'package:winter_gemini_ai/config/constants/app_color.dart';

class OnBoardingInfo extends StatelessWidget {
  const OnBoardingInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'You AI Assistant',
            style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: AppColors.primary),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            textAlign: TextAlign.center,
            '''Using this software, you can ask you questions and receive articles using artificial intelligence assistant''',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}
