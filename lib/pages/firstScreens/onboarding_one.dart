// onboarding_one.dart
import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/onboarding.dart';

class OnboardingScreenOne extends StatelessWidget {
  const OnboardingScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardingComponent(currentIndex: 0);
  }
}