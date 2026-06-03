import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/components/top_bar.dart';

class FirstAidScreen extends StatelessWidget {
  const FirstAidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),

          child: Column(
            children: [
              // ================= TOP BAR =================
              TopBar(
                title: "First Aid Instructions",
                actionIcon: Icons.volume_up_rounded,
                showBackButton: true,
              ),

              const SizedBox(height: 20),

              // ================= TAB BAR =================
              Container(
                height: 50,
                padding: const EdgeInsets.all(5),

                decoration: BoxDecoration(
                  color: ColorConstants.border.withValues(alpha: 0.4),
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

              // ================= STEPS LIST =================
              Expanded(
                child: ListView(
                  children: const [
                    StepTile(
                      stepNumber: "1",
                      icon: Icons.water_drop_outlined,
                      title: "Cool the burn",
                      description:
                          "Run cool (not cold) water over the burn for 10–20 minutes.",
                    ),

                    SizedBox(height: 24),

                    StepTile(
                      stepNumber: "2",
                      icon: Icons.clean_hands_outlined,
                      title: "Clean gently",
                      description:
                          "Gently clean the area with mild soap and water.",
                    ),

                    SizedBox(height: 24),

                    StepTile(
                      stepNumber: "3",
                      icon: Icons.medication_outlined,
                      title: "Apply ointment",
                      description:
                          "Use aloe vera gel or an antibiotic ointment.",
                    ),

                    SizedBox(height: 24),

                    StepTile(
                      stepNumber: "4",
                      icon: Icons.health_and_safety_outlined,
                      title: "Cover it",
                      description:
                          "Cover the burn with a clean, non-stick bandage or cloth.",
                    ),
                  ],
                ),
              ),

              // ================= VOICE GUIDE BUTTON =================
              SizedBox(
                width: double.infinity,
                height: 58,

                child: ElevatedButton.icon(
                  onPressed: () {},

                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.primary,
                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  icon: const Icon(
                    Icons.volume_up_rounded,
                    color: Colors.white,
                  ),

                  label: Text("Voice Guide", style: AppTextStyles.button),
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
              Icon(icon, color: ColorConstants.primary, size: 28),

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
                      style: AppTextStyles.body.copyWith(fontSize: 14),
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
