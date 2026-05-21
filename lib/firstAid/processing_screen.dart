import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/bottom_navigation_bar.dart';
import 'package:mediaid_ui/components/buttons.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/firstAid/result_screen.dart';

class ProcessingScreen extends StatelessWidget {
  const ProcessingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ================= TOP BAR =================
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.offAll(BottomNavBar());
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: ColorConstants.background,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // ================= SCANNING ANIMATION =================
              const ProcessingAnimation(),

              const SizedBox(height: 40),

              // ================= TITLE =================
              Text(
                "Analyzing Injury...",
                style: AppTextStyles.heading.copyWith(
                  fontSize: 26,
                  color: ColorConstants.background,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 14),

              // ================= DESCRIPTION =================
              Text(
                "Please wait a moment.",
                style: AppTextStyles.body.copyWith(
                  color: ColorConstants.background,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // ================= PROGRESS =================
              Container(
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),

                child: SizedBox(
                  width: 280,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      const Icon(
                        Icons.verified_user,
                        color: ColorConstants.primary,
                        size: 35,
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          "Our AI is checking the injury\nand assessing the severity.",

                          style: AppTextStyles.body,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              PrimaryButton(
                text: "Check Result",
                onPressed: () => Get.to(const FirstAidScreen())
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

// ================ PROCESSING ANIMATION ===================

class ProcessingAnimation extends StatelessWidget {
  const ProcessingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 270,
          width: 270,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorConstants.background.withValues(alpha: 0.1),
          ),
        ),
        Container(
          height: 220,
          width: 220,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorConstants.background.withValues(alpha: 0.08),
          ),
        ),

        Container(
          height: 170,
          width: 170,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorConstants.background.withValues(alpha: 0.15),
          ),
        ),

        Container(
          height: 120,
          width: 120,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ColorConstants.primary,
          ),

          child: const Icon(
            Icons.health_and_safety_rounded,
            color: Colors.white,
            size: 58,
          ),
        ),
      ],
    );
  }
}
