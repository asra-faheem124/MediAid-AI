import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/onboarding.dart';

class OnboardingScreenOne extends StatelessWidget {
  const OnboardingScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingComponent(
      text: "Scan injuries",
      coloredText: "Instantly",
      description:
          "Use AI to detect injuries quickly\nand accurately.",
      imagePath: "assets/images/onboarding1.png", currentIndex: 0,
    );
  }
}