import 'package:flutter/material.dart';
import 'package:winter_gemini_ai/config/constants/app_color.dart';
import 'package:winter_gemini_ai/config/constants/app_images.dart';
import 'package:winter_gemini_ai/config/helpers/local_storage.dart';
import 'package:winter_gemini_ai/pages/chat/page.dart';
import 'package:winter_gemini_ai/pages/on_boarding/widgets/onboarding_info.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 67,
            ),
            // INFO
            const OnBoardingInfo(),
            const Spacer(),
            // IMAGE
            Container(
              width: double.infinity,
              height: 324,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.onboarding),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Spacer(),
            // BUTTOON
            Container(
              width: double.infinity,
              height: 56,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                onPressed: () {
                  final isFirstTime = LocalStorage().isFirstTime;
                  if (isFirstTime) {
                    LocalStorage().setFirstTime(false);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const ChatPage()),
                        (route) => false);
                  }
                },
                child: Stack(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textWhite),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        AppImages.arrowRight,
                        height: 24,
                        width: 24,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
