// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mediaid_ui/components/constants.dart';
// import 'package:mediaid_ui/components/text_styles.dart';
// import 'package:mediaid_ui/pages/firstAid/result_screen.dart';

// class ProcessingScreen extends StatelessWidget {
//   const ProcessingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Auto navigate to result after 3 seconds
//     Future.delayed(const Duration(seconds: 3), () {
//       Get.off(() => const ResultScreen());
//     });

//     return Scaffold(
//       backgroundColor: ColorConstants.primary,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [

//               // ================= TOP BAR =================
//               // No back button — user should wait
//               const SizedBox(height: 20),

//               const Spacer(),

//               // ================= ANIMATION =================
//               const ProcessingAnimation(),

//               const SizedBox(height: 40),

//               // ================= TITLE =================
//               Text(
//                 "Analyzing Injury...",
//                 style: AppTextStyles.heading.copyWith(
//                   fontSize: 26,
//                   color: ColorConstants.background,
//                 ),
//                 textAlign: TextAlign.center,
//               ),

//               const SizedBox(height: 14),

//               Text(
//                 "Please wait a moment.",
//                 style: AppTextStyles.body.copyWith(
//                   color: ColorConstants.background,
//                 ),
//                 textAlign: TextAlign.center,
//               ),

//               const SizedBox(height: 30),

//               // ================= INFO CARD =================
//               Container(
//                 padding: const EdgeInsets.all(18),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(24),
//                 ),
//                 child: SizedBox(
//                   width: 280,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Icon(
//                         Icons.verified_user,
//                         color: ColorConstants.primary,
//                         size: 35,
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: Text(
//                           "Our AI is checking the injury\nand assessing the severity.",
//                           style: AppTextStyles.body,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 30),

//               // ================= LOADING DOTS =================
//               const _LoadingDots(),

//               const Spacer(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ── Animated Loading Dots ────────────────────────────────
// class _LoadingDots extends StatefulWidget {
//   const _LoadingDots();

//   @override
//   State<_LoadingDots> createState() => _LoadingDotsState();
// }

// class _LoadingDotsState extends State<_LoadingDots>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 900),
//     )..repeat();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(3, (index) {
//             final delay = index / 3;
//             final opacity = ((_controller.value - delay) % 1.0).abs();
//             return Container(
//               margin: const EdgeInsets.symmetric(horizontal: 5),
//               height: 12,
//               width: 12,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white.withValues(
//                   alpha: opacity < 0.5 ? 1.0 : 0.3,
//                 ),
//               ),
//             );
//           }),
//         );
//       },
//     );
//   }
// }

// // ================ PROCESSING ANIMATION ==================
// class ProcessingAnimation extends StatelessWidget {
//   const ProcessingAnimation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           height: 270, width: 270,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: ColorConstants.background.withValues(alpha: 0.1),
//           ),
//         ),
//         Container(
//           height: 220, width: 220,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: ColorConstants.background.withValues(alpha: 0.08),
//           ),
//         ),
//         Container(
//           height: 170, width: 170,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: ColorConstants.background.withValues(alpha: 0.15),
//           ),
//         ),
//         Container(
//           height: 120, width: 120,
//           decoration: const BoxDecoration(
//             shape: BoxShape.circle,
//             color: ColorConstants.primary,
//           ),
//           child: const Icon(
//             Icons.health_and_safety_rounded,
//             color: Colors.white,
//             size: 58,
//           ),
//         ),
//       ],
//     );
//   }
// }

// ============================================================
// processing_screen.dart
// Shown while TFLite inference runs in background.
// Navigation away is handled by ScanController — NOT here.
// ============================================================

import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';

class ProcessingScreen extends StatelessWidget {
  const ProcessingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ⚠️  Do NOT put a Future.delayed here.
    //     ScanController.analyzeImage() calls Get.off(ResultScreen)
    //     as soon as inference is complete.

    return Scaffold(
      backgroundColor: ColorConstants.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Spacer(),

              // ================= ANIMATION =================
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

              Text(
                "Please wait a moment.",
                style: AppTextStyles.body.copyWith(
                  color: ColorConstants.background,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // ================= INFO CARD =================
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

              const SizedBox(height: 30),

              // ================= LOADING DOTS =================
              const _LoadingDots(),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Animated Loading Dots ─────────────────────────────────────
class _LoadingDots extends StatefulWidget {
  const _LoadingDots();

  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            final delay   = index / 3;
            final opacity = ((_controller.value - delay) % 1.0).abs();
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              height: 12,
              width:  12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(
                  alpha: opacity < 0.5 ? 1.0 : 0.3,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

// ── Processing Animation ──────────────────────────────────────
class ProcessingAnimation extends StatelessWidget {
  const ProcessingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 270, width: 270,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorConstants.background.withValues(alpha: 0.1),
          ),
        ),
        Container(
          height: 220, width: 220,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorConstants.background.withValues(alpha: 0.08),
          ),
        ),
        Container(
          height: 170, width: 170,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorConstants.background.withValues(alpha: 0.15),
          ),
        ),
        Container(
          height: 120, width: 120,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ColorConstants.primary,
          ),
          child: const Icon(
            Icons.health_and_safety_rounded,
            color: Colors.white,
            size:  58,
          ),
        ),
      ],
    );
  }
}