import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/cards.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: ColorConstants.heading),
          onPressed: () {},
        ),
        title: Text(
          "Analysis Result",
          style: AppTextStyles.subHeading.copyWith(
            fontWeight: FontWeight.bold,
            color: ColorConstants.heading,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share_outlined, color: ColorConstants.heading),
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            children: [
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
                    child: Text(
                      "🔥",
                      style: TextStyle(fontSize: 26),
                    ),
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
              const BottomActionButtons(),

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


// =====================================================
// BOTTOM BUTTONS
// =====================================================

class BottomActionButtons extends StatelessWidget {
  const BottomActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
              side: const BorderSide(color: ColorConstants.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: Text(
              "View First Aid",
              style: AppTextStyles.primaryText,
            ),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.danger,
              elevation: 0,
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: Text(
              "Emergency Help",
              style: AppTextStyles.button,
            ),
          ),
        ),
      ],
    );
  }
}