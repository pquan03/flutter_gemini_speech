import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:winter_gemini_ai/config/constants/app_images.dart';

class TypingMessage extends StatelessWidget {
  const TypingMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 32),
        child: ListTile(
          title: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Lottie.asset(height: 40, width: 50, AppImages.typing),
            ),
          ),
        ));
  }
}
