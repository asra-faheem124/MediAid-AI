import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/buttons.dart';
import 'package:mediaid_ui/components/cards.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/components/top_bar.dart';
import 'package:mediaid_ui/pages/firstAid/emergency_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),

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
                    // =====================================================
                    // ================= RESULT SECTION ====================
                    // =====================================================

                    ResultInfoCard(
                      title: "Detected Injury",
                      value: "Burn",

                      trailing: Container(
                        height: 54,
                        width: 54,

                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),

                        child: const Center(
                          child: Text(
                            "🔥",
                            style: TextStyle(fontSize: 26),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // =====================================================
                    // =========== CONFIDENCE + SEVERITY ===================
                    // =====================================================

                    Row(
                      children: [
                        Expanded(
                          child: ResultInfoCard(
                            title: "Confidence",
                            value: "87%",

                            valueStyle: AppTextStyles.success.copyWith(
                              fontSize: 22,
                            ),
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: ResultInfoCard(
                            title: "Severity",
                            value: "High",

                            valueStyle: AppTextStyles.danger.copyWith(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // =====================================================
                    // ================= RECOMMENDATION ====================
                    // =====================================================

                    const RecommendationCard(),

                    const SizedBox(height: 28),

                    // =====================================================
                    // ================= SECTION TITLE =====================
                    // =====================================================

                    Align(
                      alignment: Alignment.centerLeft,

                      child: Text(
                        "First Aid Instructions",

                        style: AppTextStyles.subHeading.copyWith(
                          color: ColorConstants.heading,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // =====================================================
                    // ===================== TAB BAR =======================
                    // =====================================================

                    Container(
                      height: 50,
                      padding: const EdgeInsets.all(5),

                      decoration: BoxDecoration(
                        color:
                            ColorConstants.border.withValues(alpha: 0.4),

                        borderRadius: BorderRadius.circular(16),
                      ),

                      child: Row(
                        children: [
                          // ACTIVE TAB

                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorConstants.primary,

                                borderRadius: BorderRadius.circular(12),
                              ),

                              child: Center(
                                child: Text(
                                  "Steps",

                                  style: AppTextStyles.body.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child: Center(
                              child: Text(
                                "Do's",

                                style: AppTextStyles.body.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child: Center(
                              child: Text(
                                "Don'ts",

                                style: AppTextStyles.body.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // =====================================================
                    // ===================== STEPS =========================
                    // =====================================================

                    const StepTile(
                      stepNumber: "1",
                      icon: Icons.water_drop_outlined,
                      title: "Cool the burn",

                      description:
                          "Run cool (not cold) water over the burn for 10–20 minutes.",
                    ),

                    const SizedBox(height: 24),

                    const StepTile(
                      stepNumber: "2",
                      icon: Icons.clean_hands_outlined,
                      title: "Clean gently",

                      description:
                          "Gently clean the area with mild soap and water.",
                    ),

                    const SizedBox(height: 24),

                    const StepTile(
                      stepNumber: "3",
                      icon: Icons.medication_outlined,
                      title: "Apply ointment",

                      description:
                          "Use aloe vera gel or an antibiotic ointment.",
                    ),

                    const SizedBox(height: 24),

                    const StepTile(
                      stepNumber: "4",
                      icon: Icons.health_and_safety_outlined,
                      title: "Cover it",

                      description:
                          "Cover the burn with a clean, non-stick bandage or cloth.",
                    ),

                    const SizedBox(height: 34),

                    // ================= VOICE GUIDE =======================
                    PrimaryButton(text: "Voice Guide", onPressed: () {}),
                    
                    const SizedBox(height: 16),

                    // ================= EMERGENCY BUTTON ==================

                    DangerButton(
                      text: "Emergency Help",
                      onPressed: () => Get.to(
                        const EmergencyScreen(),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // ================= DISCLAIMER ========================

                    Text(
                      "This is not a substitute for professional medical advice.",

                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption,
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
}

// =========================================================
// ====================== STEP TILE ========================
// =========================================================

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
        // ================= STEP NUMBER =================

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

              style: AppTextStyles.body.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(width: 16),

        // ================= CONTENT =================

        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Icon(
                icon,
                color: ColorConstants.primary,
                size: 28,
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      title,

                      style: AppTextStyles.subHeading.copyWith(
                        fontSize: 16,
                        color: ColorConstants.heading,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      description,

                      style: AppTextStyles.body.copyWith(
                        fontSize: 14,
                      ),
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
