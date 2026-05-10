import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/textStyles.dart';

class OnboardingScreenOne extends StatelessWidget {
  const OnboardingScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),

          child: Column(
            children: [

              // Skip Button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {},

                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      color: ColorConstants.bodyText,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Illustration
              const OnboardingIllustration(),

              const SizedBox(height: 40),

              // Heading
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: AppTextStyles.heading,
                  children: [

                    TextSpan(
                      text: "Scan injuries\n",
                    ),

                    TextSpan(
                      text: "instantly",
                      style: TextStyle(
                        color: ColorConstants.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Description
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Use AI to detect injuries quickly\nand accurately.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body,
                ),
              ),

              const SizedBox(height: 30),

              // Indicator
              const OnboardingIndicator(
                currentIndex: 0,
              ),

              const SizedBox(height: 40),

              // Next Button
              const PrimaryButton(),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}







// =================== ILLUSTRATION ===================

class OnboardingIllustration extends StatelessWidget {
  const OnboardingIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,

      child: Stack(
        alignment: Alignment.center,

        children: [

          // Injury Scan Box
          Positioned(
            right: 20,
            top: 30,

            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: ColorConstants.primary.withValues(alpha: 0.8),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Person Image
          Image.asset(
            "assets/images/onboarding1.png",
            height: 220,
          ),

          // Scan Frame
          Positioned(
            right: 30,
            top: 45,

            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorConstants.primary,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}







// =================== PAGE INDICATOR ===================

class OnboardingIndicator extends StatelessWidget {
  final int currentIndex;

  const OnboardingIndicator({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: List.generate(
        3,
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







// =================== PRIMARY BUTTON ===================

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,

      child: ElevatedButton(
        onPressed: () {},

        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: const [

            Text(
              "Next",
              style: AppTextStyles.button,
            ),

            SizedBox(width: 10),

            Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}