import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';

// ================= SCAN CARD =================

class ScanCard extends StatelessWidget {
  final VoidCallback onTap;

  const ScanCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [ColorConstants.primaryDark, ColorConstants.primary],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                    size: 34,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  "Scan Injury",
                  style: AppTextStyles.subHeading.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  "Tap to scan now",
                  style: AppTextStyles.lightBody.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================= ACTION CARD =================

class ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: ColorConstants.border),
          ),
          child: Column(
            children: [
              Icon(icon, color: iconColor, size: 30),
              const SizedBox(height: 10),
              Text(
                title,
                style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= SAFETY CARD =================

class SafetyCard extends StatelessWidget {
  const SafetyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: ColorConstants.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Stay prepared. Stay safe.",
                  style: AppTextStyles.subHeading.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  "MediAid AI is here to help you in emergencies.",
                  style: AppTextStyles.lightBody,
                ),
              ],
            ),
          ),
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: ColorConstants.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shield_rounded,
              color: ColorConstants.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// ================= RESULT INFO CARD =================

class ResultInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final TextStyle? valueStyle;
  final Widget? trailing;

  const ResultInfoCard({
    super.key,
    required this.title,
    required this.value,
    this.valueStyle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: ColorConstants.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.lightBody),
                const SizedBox(height: 10),
                Text(
                  value,
                  style:
                      valueStyle ??
                      AppTextStyles.title.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

// ================= RECOMMENDATION CARD =================

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: ColorConstants.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "AI Recommendation",
            style: AppTextStyles.subHeading.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 12),
          Text(
            "It is recommended to seek medical attention immediately.",
            style: AppTextStyles.danger.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}
