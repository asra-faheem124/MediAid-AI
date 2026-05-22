import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/firstScreens/onboarding_one.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingScreenOne(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,

      body: Stack(
        children: [
          // Bottom Background Shapes
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,

            child: Container(
              height: 170,

              decoration: BoxDecoration(
                color: ColorConstants.primary.withValues(alpha: 0.2),

                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(120),
                  topRight: Radius.circular(120),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: -20,
            left: -40,

            child: Container(
              width: 240,
              height: 120,

              decoration: BoxDecoration(
                color: ColorConstants.primary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),

          Positioned(
            bottom: -25,
            right: -30,

            child: Container(
              width: 230,
              height: 120,

              decoration: BoxDecoration(
                color: ColorConstants.primaryLight.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  // Logo Box
                  Container(
                    width: 125,
                    height: 125,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),

                      boxShadow: [
                        BoxShadow(
                          color: ColorConstants.primaryLight.withValues(
                            alpha: 0.5,
                          ),

                          blurRadius: 25,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),

                      child: Image.asset(
                        "assets/images/Mediaid AI Logo.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  // App Name
                  const Text(
                    "MediAid AI",

                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.primary,
                      letterSpacing: 0.5,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Subtitle
                  const Text(
                    "Smart First Aid Assistant",
                    style: AppTextStyles.subHeading,
                  ),

                  const SizedBox(height: 60),

                  // Loading Bar
                  Container(
                    width: 120,
                    height: 6,

                    decoration: BoxDecoration(
                      color: ColorConstants.border,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Align(
                      alignment: Alignment.centerLeft,

                      child: Container(
                        width: 60,

                        decoration: BoxDecoration(
                          color: ColorConstants.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}