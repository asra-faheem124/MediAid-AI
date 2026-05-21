import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/bottom_navigation_bar.dart';
import 'package:mediaid_ui/components/buttons.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/onboarding_indicator.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/firstScreens/onboarding_two.dart';

class OnboardingComponent extends StatelessWidget {
  final String text;
  final String coloredText;
  final String description;
  final String imagePath;
  final int currentIndex;

  const OnboardingComponent({
    super.key,
    required this.text,
    required this.coloredText,
    required this.description,
    required this.imagePath,
    required this.currentIndex,
  });

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
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => BottomNavBar()),
                    );
                  },

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
              SizedBox(
                height: 380,

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
                    Image.asset(imagePath, height: 320),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Heading
              RichText(
                textAlign: TextAlign.center,

                text: TextSpan(
                  style: AppTextStyles.heading,

                  children: [
                    TextSpan(text: text),
                    const TextSpan(text: "\n"),

                    TextSpan(
                      text: coloredText,

                      style: const TextStyle(
                        color: ColorConstants.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),

                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body,
                ),
              ),

              const SizedBox(height: 30),

              // Indicator
              OnboardingIndicator(currentIndex: currentIndex),

              const SizedBox(height: 40),

              // Next Button
              PrimaryButton(
                text: currentIndex == 1 ? "Get Started" : "Next",

                onPressed: () {
                  if (currentIndex == 0) {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const OnboardingScreenTwo(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              // Slide from right to left
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              final tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: Curves.easeInOut));
                              final offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavBar(),
                      ),
                    );
                  }
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
