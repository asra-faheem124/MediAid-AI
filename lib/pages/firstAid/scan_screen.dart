import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/buttons.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/controller/ScanController.dart';

class ScanScreen extends StatelessWidget {
  ScanScreen({super.key});

  final ScanController scanController = Get.put(ScanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ================= TOP BAR =================
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      scanController.reset();
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: ColorConstants.heading,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text("Scan Injury", style: AppTextStyles.title),
                ],
              ),

              const SizedBox(height: 24),

              // ================= IMAGE AREA =================
              Obx(() {
                if (scanController.selectedImage.value != null) {
                  // ── Show selected image ──
                  return Column(
                    children: [
                      Container(
                        height: 320,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: ColorConstants.primary,
                            width: 2,
                          ),
                          image: DecorationImage(
                            image: FileImage(
                              scanController.selectedImage.value!,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Retake option
                      GestureDetector(
                        onTap: () => scanController.reset(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.refresh_rounded,
                              color: ColorConstants.primary,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Retake or choose different photo",
                              style: AppTextStyles.primaryText.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                // ── No image yet → show placeholder ──
                return GestureDetector(
                  onTap: () => scanController.pickFromCamera(),
                  child: Container(
                    height: 320,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorConstants.primary.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: ColorConstants.primary.withValues(alpha: 0.3),
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignInside,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: ColorConstants.primary.withValues(
                              alpha: 0.1,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: ColorConstants.primary,
                            size: 44,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Tap to take a photo",
                          style: AppTextStyles.subHeading.copyWith(
                            color: ColorConstants.primary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Point camera at the injury clearly",
                          style: AppTextStyles.lightBody,
                        ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 24),

              // ================= TIPS CARD =================
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: ColorConstants.warning.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: ColorConstants.warning.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline_rounded,
                      color: ColorConstants.warning,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "For best results: good lighting, clear view of injury, steady hand.",
                        style: AppTextStyles.lightBody.copyWith(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // ================= BOTTOM BUTTONS =================
              Obx(() {
                if (scanController.selectedImage.value != null) {
                  // Image selected → show Analyze button
                  return PrimaryButton(
                    text: "Analyze Injury",
                    onPressed: () => scanController.analyzeImage(),
                  );
                }

                // No image → show camera + gallery
                return Column(
                  children: [
                    PrimaryButton(
                      text: "Take Photo",
                      onPressed: () => scanController.pickFromCamera(),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: () => scanController.pickFromGallery(),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                        side: const BorderSide(color: ColorConstants.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      icon: const Icon(
                        Icons.photo_library_outlined,
                        color: ColorConstants.primary,
                      ),
                      label: Text(
                        "Choose from Gallery",
                        style: AppTextStyles.primaryText,
                      ),
                    ),
                  ],
                );
              }),

              const SizedBox(height: 16),

              // ================= DISCLAIMER =================
              const Text(
                "⚠️ Not a substitute for professional medical advice.",
                style: AppTextStyles.caption,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}