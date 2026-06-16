import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/buttons.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/pages/firstScreens/onboarding_two.dart';
import 'package:mediaid_ui/pages/firstScreens/welcome_screen.dart';
import 'package:mediaid_ui/services/AuthService.dart';

class OnboardingComponent extends StatelessWidget {
  final int currentIndex;

  const OnboardingComponent({
    super.key,
    required this.currentIndex,
  });

  Future<void> _finishOnboarding() async {
    final authService = Get.find<Authservice>();
    await authService.completeOnboarding();
    Get.offAll(() => const WelcomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
          child: Column(
            children: [

              // ── Skip ─────────────────────────────────
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _finishOnboarding,
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

              Expanded(
                child: currentIndex == 0
                    ? _buildScreenOne()
                    : _buildScreenTwo(),
              ),

              const SizedBox(height: 24),

              // ── Dots indicator ───────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  2,
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
              ),

              const SizedBox(height: 24),

              // ── Button ───────────────────────────────
              PrimaryButton(
                text: currentIndex == 0 ? "Next" : "Get Started",
                onPressed: () {
                  if (currentIndex == 0) {
                    Get.to(
                      () => const OnboardingScreenTwo(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                    );
                  } else {
                    _finishOnboarding();
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

  // ═════════ SCREEN 1 ═════════
  Widget _buildScreenOne() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),

          Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.heading,
                ),
                children: [
                  TextSpan(text: "How to use\n"),
                  TextSpan(
                    text: "MediAid AI",
                    style: TextStyle(color: ColorConstants.primary),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 28),

          _GuideItem(
            icon: Icons.camera_alt_rounded,
            iconColor: ColorConstants.primary,
            title: "Scan the Injury",
            description:
                "Tap 'Scan Injury' on the home screen. Take a clear photo or pick from gallery.",
          ),

          const SizedBox(height: 16),

          _GuideItem(
            icon: Icons.analytics_outlined,
            iconColor: ColorConstants.primaryDark,
            title: "Read the Results",
            description:
                "AI detects injury type and shows steps, Do's and Don'ts.",
          ),

          const SizedBox(height: 16),

          _GuideItem(
            icon: Icons.warning_amber_rounded,
            iconColor: ColorConstants.warning,
            title: "Understand Severity",
            description:
                "Every scan shows severity so you know what to do.",
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ColorConstants.border.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              children: [
                _SeverityRow(
                  color: ColorConstants.success,
                  label: "Low",
                  description: "Treat at home",
                ),
                SizedBox(height: 10),
                _SeverityRow(
                  color: ColorConstants.warning,
                  label: "Medium",
                  description: "Monitor closely",
                ),
                SizedBox(height: 10),
                _SeverityRow(
                  color: ColorConstants.danger,
                  label: "High",
                  description: "Seek medical help",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═════════ SCREEN 2 ═════════
  Widget _buildScreenTwo() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),

          Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.heading,
                ),
                children: [
                  TextSpan(text: "Built for\n"),
                  TextSpan(
                    text: "Real Emergencies",
                    style: TextStyle(color: ColorConstants.primary),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 28),

          _GuideItem(
            icon: Icons.wifi_off_rounded,
            iconColor: ColorConstants.primary,
            title: "Works Offline",
            description:
                "Works without internet after first login.",
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: ColorConstants.primary.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: ColorConstants.primary.withValues(alpha: 0.2),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline_rounded,
                    color: ColorConstants.primary, size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Login once online — works offline later.",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          _GuideItem(
            icon: Icons.emergency_rounded,
            iconColor: ColorConstants.danger,
            title: "Emergency Help",
            description:
                "Call or find hospital instantly.",
          ),

          const SizedBox(height: 16),

          _GuideItem(
            icon: Icons.volume_up_rounded,
            iconColor: ColorConstants.primaryDark,
            title: "Voice Guide",
            description:
                "Hear instructions in emergencies.",
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: ColorConstants.warning.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: ColorConstants.warning.withValues(alpha: 0.3),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.warning_amber_rounded,
                    color: ColorConstants.warning, size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Not a replacement for medical advice.",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════ GUIDE ITEM ═════════
class _GuideItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;

  const _GuideItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: iconColor, size: 26),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.subHeading(context).copyWith(
                  fontSize: 16,
                  color: ColorConstants.heading,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: AppTextStyles.lightBody(context).copyWith(fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ═════════ SEVERITY ROW ═════════
class _SeverityRow extends StatelessWidget {
  final Color color;
  final String label;
  final String description;

  const _SeverityRow({
    required this.color,
    required this.label,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          "$label — ",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: AppTextStyles.caption(context),
          ),
        ),
      ],
    );
  }
}