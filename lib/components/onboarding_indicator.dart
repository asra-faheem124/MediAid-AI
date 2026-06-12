import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/constants.dart';

class OnboardingIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalCount; // dynamic 

  const OnboardingIndicator({
    super.key,
    required this.currentIndex,
    this.totalCount = 2, // default 2
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalCount,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentIndex == index ? 22 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? ColorConstants.primary
                : ColorConstants.border,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}