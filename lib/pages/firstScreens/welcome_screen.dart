import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/buttons.dart';
import 'package:mediaid_ui/components/cards.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/components/bottom_navigation_bar.dart';
import 'package:mediaid_ui/pages/auth/login_screen.dart';
import 'package:mediaid_ui/pages/auth/signup_screen.dart';
import 'package:mediaid_ui/services/AuthService.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Authservice authService = Get.find<Authservice>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // ── Top decorative circle ──────────────────────
            Positioned(
              top: -60,
              right: -50,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark
                      ? ColorConstants.primary.withValues(alpha: 0.05)
                      : ColorConstants.primary.withValues(alpha: 0.08),
                ),
              ),
            ),

            Positioned(
              top: 40,
              right: 20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark
                      ? ColorConstants.primary.withValues(alpha: 0.04)
                      : ColorConstants.primaryLight.withValues(alpha: 0.12),
                ),
              ),
            ),

            // Main Content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 48),

                    // Logo
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: [
                          BoxShadow(
                            color: ColorConstants.primaryLight.withValues(
                              alpha: 0.3,
                            ),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(26),
                        child: Image.asset("assets/images/Mediaid AI Logo.png"),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // App Name
                    Text("MediAid AI", style: AppTextStyles.heading(context)),

                    const SizedBox(height: 8),

                    Text(
                      "Smart First Aid Assistant",
                      style: AppTextStyles.subHeading(context),
                    ),

                    const SizedBox(height: 30),

                    // Feature Pills
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FeaturePill(
                          icon: Icons.wifi_off_rounded,
                          label: "Works Offline",
                        ),
                        const SizedBox(width: 10),
                        FeaturePill(
                          icon: Icons.bolt_rounded,
                          label: "AI Powered",
                        ),
                        const SizedBox(width: 10),
                        FeaturePill(
                          icon: Icons.shield_outlined,
                          label: "Reliable",
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Illustration / Tagline Card
                    TaglineCard(),

                    const SizedBox(height: 40),

                    // Buttons
                    PrimaryButton(
                      text: "Get Started",
                      onPressed: () => Get.to(() => SignupScreen()),
                    ),

                    const SizedBox(height: 12),

                    SecondaryButtons(
                      text: "I already have an account",
                      onPressed: () => Get.to(() => LoginScreen()),
                    ),

                    const SizedBox(height: 12),

                    // Guest Mode
                    GestureDetector(
                      onTap: () async {
                        await authService.continueAsGuest();
                        Get.offAll(() => BottomNavBar());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Continue without account  ",
                              style: AppTextStyles.lightBody(context),
                            ),
                            Text(
                              "Guest Mode",
                              style: AppTextStyles.primaryText.copyWith(
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                                decorationColor: ColorConstants.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Disclaimer
                    Text(
                      "⚠️ This app provides basic first aid guidance only.\nNot a replacement for professional medical care.",
                      style: AppTextStyles.caption(context),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 24),
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
