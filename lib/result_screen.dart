import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/buttons.dart';
import 'package:mediaid_ui/components/cards.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/components/top_bar.dart';
import 'package:mediaid_ui/emergency_screen.dart';
import 'package:mediaid_ui/first_aid_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            children: [
              // Top Bar
              TopBar(
                title: "Analysis Result",
                actionIcon: Icons.share_outlined,
              ),
              const SizedBox(height: 20),

              // Injury Result Card
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
                    child: Text("🔥", style: TextStyle(fontSize: 26)),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Confidence + Severity
              Row(
                children: [
                  Expanded(
                    child: ResultInfoCard(
                      title: "Confidence",
                      value: "87%",
                      valueStyle: AppTextStyles.success.copyWith(fontSize: 22),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: ResultInfoCard(
                      title: "Severity Level",
                      value: "High",
                      valueStyle: AppTextStyles.danger.copyWith(fontSize: 20),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Recommendation
              const RecommendationCard(),

              const Spacer(),

              // Bottom Buttons
              Row(
                children: [
                  Expanded(
                    child: SecondaryButtons(
                      text: "View First Aid",
                      onPressed: () => Get.to(FirstAidScreen()),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: DangerButton(
                      text: "Emergency Help",
                      onPressed: () => Get.to(EmergencyScreen()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Text(
                "This is not a substitute for professional medical advice.",
                textAlign: TextAlign.center,
                style: AppTextStyles.caption,
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
