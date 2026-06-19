// ============================================================
// result_screen.dart
// Displays real model output from ScanController.result
// ============================================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/buttons.dart';
import 'package:mediaid_ui/components/cards.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/components/top_bar.dart';
import 'package:mediaid_ui/controller/ScanController.dart';
import 'package:mediaid_ui/model/resultModel.dart';
import 'package:mediaid_ui/pages/firstAid/emergency_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScanController scanController = Get.find<ScanController>();
    final ResultModel? result = scanController.result.value;

    // Safety fallback — should never be null here
    if (result == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              const Text('No result available.'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    // ── Severity color ──────────────────────────────────────────
    Color severityColor = switch (result.severityLevel) {
      'severe' => ColorConstants.danger,
      'moderate' => ColorConstants.warning,
      'mild' => ColorConstants.success,
      _ => ColorConstants.success, // none
    };

    final bool isEmergency = result.goHospital;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            children: [
              // ================= TOP BAR =================
              const TopBar(
                title: "Injury Analysis",
                actionIcon: Icons.volume_up_rounded,
                showBackButton: true,
              ),

              const SizedBox(height: 20),

              // ================= BODY =================
              Expanded(
                child: ListView(
                  children: [
                    // ─────────────────────────────────────────────
                    // DETECTED INJURY CARD
                    // ─────────────────────────────────────────────
                    ResultInfoCard(
                      title: "Detected Injury",
                      value: result.injury, // e.g. "Diabetic Wounds"
                      trailing: Container(
                        height: 54,
                        width: 54,
                        decoration: BoxDecoration(
                          color: severityColor.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            result.injuryEmoji,
                            style: const TextStyle(fontSize: 26),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ─────────────────────────────────────────────
                    // CONFIDENCE + SEVERITY ROW
                    // ─────────────────────────────────────────────
                    Row(
                      children: [
                        Expanded(
                          child: ResultInfoCard(
                            title: "Confidence",
                            value: result.confidencePercent,
                            valueStyle: AppTextStyles.success.copyWith(
                              fontSize: 22,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: ResultInfoCard(
                            title: "Severity",
                            value: _capitalizeFirst(result.severity),
                            valueStyle: AppTextStyles.danger.copyWith(
                              fontSize: 20,
                              color: severityColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ─────────────────────────────────────────────
                    // DECISION / RECOMMENDATION BANNER
                    // ─────────────────────────────────────────────
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: severityColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: severityColor.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            result.goHospital
                                ? Icons.local_hospital_rounded
                                : Icons.home_rounded,
                            color: severityColor,
                            size: 24,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              result.decision,
                              style: AppTextStyles.body(context).copyWith(
                                color: severityColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ─────────────────────────────────────────────
                    // FIRST AID STEPS TITLE
                    // ─────────────────────────────────────────────
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "First Aid Instructions",
                        style: AppTextStyles.subHeading(context),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // ─────────────────────────────────────────────
                    // STEPS — dynamically built from model output
                    // ─────────────────────────────────────────────
                    ...result.firstAidSteps.asMap().entries.map((entry) {
                      final index = entry.key;
                      final step = entry.value;

                      // Cycle through relevant icons
                      const stepIcons = [
                        Icons.water_drop_outlined,
                        Icons.clean_hands_outlined,
                        Icons.medication_outlined,
                        Icons.health_and_safety_outlined,
                        Icons.warning_amber_rounded,
                      ];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: StepTile(
                          stepNumber: "${index + 1}",
                          icon: stepIcons[index % stepIcons.length],
                          title: "Step ${index + 1}",
                          description: step,
                        ),
                      );
                    }),

                    const SizedBox(height: 10),

                    // ─────────────────────────────────────────────
                    // OFFLINE / ONLINE BADGE
                    // ─────────────────────────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          result.isOffline
                              ? Icons.offline_bolt_rounded
                              : Icons.cloud_done_rounded,
                          size: 14,
                          color: ColorConstants.danger,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          result.isOffline
                              ? 'Analyzed offline'
                              : 'Analyzed via server',
                          style: AppTextStyles.caption(context),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // ─────────────────────────────────────────────
                    // VOICE GUIDE BUTTON
                    // ─────────────────────────────────────────────
                    PrimaryButton(
                      text: "Voice Guide",
                      onPressed: () {
                        // TODO: plug in TTS — pass result.firstAidSteps
                      },
                    ),

                    const SizedBox(height: 16),

                    // ─────────────────────────────────────────────
                    // EMERGENCY BUTTON (shown for all, prominent for severe)
                    // ─────────────────────────────────────────────
                    if (isEmergency) ...[
                      DangerButton(
                        text: "Emergency Help",
                        onPressed: () => Get.to(const EmergencyScreen()),
                      ),
                      const SizedBox(height: 18),
                    ],

                    const SizedBox(height: 18),

                    // ─────────────────────────────────────────────
                    // SCAN AGAIN
                    // ─────────────────────────────────────────────
                    SecondaryButtons(
                      text: "Scan Another Injury",
                      onPressed: () {
                        scanController.reset();
                        Get.until((route) => route.isFirst);
                      },
                    ),

                    const SizedBox(height: 8),

                    // ─────────────────────────────────────────────
                    // DISCLAIMER
                    // ─────────────────────────────────────────────
                    Text(
                      "This is not a substitute for professional medical advice.",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption(context),
                    ),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _capitalizeFirst(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}

// ============================================================
// STEP TILE — unchanged from your original
// ============================================================
class StepTile extends StatelessWidget {
  final String stepNumber;
  final IconData icon;
  final String title;
  final String description;

  const StepTile({
    super.key,
    required this.stepNumber,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Step number circle
        Container(
          height: 38,
          width: 38,
          decoration: const BoxDecoration(
            color: ColorConstants.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              stepNumber,
              style: AppTextStyles.body(
                context,
              ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: ColorConstants.primary, size: 28),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.subHeading(context)),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: AppTextStyles.body(context).copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
