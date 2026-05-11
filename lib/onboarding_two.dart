import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/onboarding.dart';

class OnboardingScreenTwo extends StatelessWidget {
  const OnboardingScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingComponent(
      text: "Get first aid guidance or",
      coloredText: "hospital advice",
      description:
          "Follow step-by-step instructions or\nknow when to seek medical help.",
      imagePath: "assets/images/onboarding2.png", currentIndex: 1,
    );
  }
}