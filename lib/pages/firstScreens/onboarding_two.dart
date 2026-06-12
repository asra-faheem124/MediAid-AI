// onboarding_two.dart
import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/onboarding.dart';

class OnboardingScreenTwo extends StatelessWidget {
  const OnboardingScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardingComponent(currentIndex: 1);
  }
}