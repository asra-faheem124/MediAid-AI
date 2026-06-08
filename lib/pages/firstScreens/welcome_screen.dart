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
    final Authservice authService = Get.find<Authservice>();

    return Scaffold(
      backgroundColor: ColorConstants.background,

      body: Stack(
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
                color: ColorConstants.primary.withValues(alpha: 0.08),
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
                color: ColorConstants.primaryLight.withValues(alpha: 0.12),
              ),
            ),
          ),

          // ── Bottom decorative shapes (matches splash) ──
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                color: ColorConstants.primary.withValues(alpha: 0.07),
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
                color: ColorConstants.primary.withValues(alpha: 0.1),
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
                color: ColorConstants.primaryLight.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),

          // ── Main Content ───────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 48),

                  // ── Logo ────────────────────────────────
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstants.primaryLight.withValues(
                            alpha: 0.4,
                          ),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: Image.asset(
                        "assets/images/Mediaid AI Logo.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── App Name ────────────────────────────
                  const Text("MediAid AI", style: AppTextStyles.heading),

                  const SizedBox(height: 8),

                  const Text(
                    "Smart First Aid Assistant",
                    style: AppTextStyles.subHeading,
                  ),

                  const SizedBox(height: 48),

                  // ── Feature Pills ────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _FeaturePill(
                        icon: Icons.wifi_off_rounded,
                        label: "Works Offline",
                      ),
                      const SizedBox(width: 10),
                      _FeaturePill(
                        icon: Icons.bolt_rounded,
                        label: "AI Powered",
                      ),
                      const SizedBox(width: 10),
                      _FeaturePill(
                        icon: Icons.shield_outlined,
                        label: "Reliable",
                      ),
                    ],
                  ),

                  const SizedBox(height: 48),

                  // ── Illustration / Tagline Card ──────────
                 TaglineCard(),

                  const Spacer(),

                  // ── Buttons ──────────────────────────────
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

                  // ── Guest Mode ───────────────────────────
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
                          const Text(
                            "Continue without account  ",
                            style: AppTextStyles.lightBody,
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

                  // ── Disclaimer ───────────────────────────
                  const Text(
                    "⚠️ This app provides basic first aid guidance only.\nNot a replacement for professional medical care.",
                    style: AppTextStyles.caption,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Feature Pill Widget ──────────────────────────────────
class _FeaturePill extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeaturePill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: ColorConstants.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ColorConstants.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: ColorConstants.primary),
          const SizedBox(width: 5),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: ColorConstants.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
