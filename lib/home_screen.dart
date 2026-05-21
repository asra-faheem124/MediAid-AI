import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/cards.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/firstAid/processing_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // ================= TOP BAR =================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu_rounded),
                ),

                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none_rounded),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ================= GREETING =================
            Text("Hello, User 👋", style: AppTextStyles.title),

            const SizedBox(height: 5),

            Text("How can we help you today?", style: AppTextStyles.body),

            const SizedBox(height: 24),

            // ================= SCAN CARD =================
            ScanCard(
              onTap: () {
                Get.to(ProcessingScreen());
              },
            ),

            const SizedBox(height: 18),

            // ================= ACTION CARDS =================
            Row(
              children: [
                Expanded(
                  child: ActionCard(
                    icon: Icons.history,
                    title: "View History",
                    iconColor: ColorConstants.primary,
                    onTap: () {},
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: ActionCard(
                    icon: Icons.notifications_active_outlined,
                    title: "Emergency",
                    iconColor: ColorConstants.danger,
                    onTap: () {},
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // ================= SAFETY CARD =================
            const SafetyCard(),
          ],
        ),
      ),
    );
  }
}
