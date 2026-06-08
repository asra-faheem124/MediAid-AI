import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/buttons.dart';
import 'package:mediaid_ui/components/cards.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/pages/firstAid/processing_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= TOP SECTION =================

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user != null ? "Hello 👋" : "Welcome to",
                      style: AppTextStyles.body,
                    ),

                    const SizedBox(height: 4),

                    Text(
                      user != null
                          ? (user.displayName ?? "User")
                          : "MediAid AI",
                      style: AppTextStyles.title,
                    ),
                  ],
                ),

                user == null
                    ? SizedBox(
                        width: 120,
                        child: SecondaryButtons(
                          text: "Login",
                          onPressed: () {
                            Get.toNamed('/login');
                          },
                        ),
                      )
                    : PopupMenuButton<String>(
                        offset: const Offset(0, 50),

                        icon: CircleAvatar(
                          radius: 22,
                          backgroundColor: ColorConstants.primary,
                          child: Text(
                            user.displayName != null &&
                                    user.displayName!.isNotEmpty
                                ? user.displayName![0].toUpperCase()
                                : "U",
                            style: AppTextStyles.button,
                          ),
                        ),

                        onSelected: (value) async {
                          switch (value) {
                            case "profile":
                              Get.toNamed('/profile');
                              break;

                            case "history":
                              Get.toNamed('/history');
                              break;

                            case "logout":
                              await FirebaseAuth.instance.signOut();

                              Get.offAllNamed('/login');
                              break;
                          }
                        },

                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: "profile",
                            child: Text("Profile"),
                          ),

                          const PopupMenuItem(
                            value: "history",
                            child: Text("Scan History"),
                          ),

                          const PopupMenuItem(
                            value: "logout",
                            child: Text("Logout"),
                          ),
                        ],
                      ),
              ],
            ),

            const SizedBox(height: 24),

            // ================= SUBTITLE =================

            Text(
              "How can we help you today?",
              style: AppTextStyles.body,
            ),

            const SizedBox(height: 24),

            // ================= SCAN CARD =================

            ScanCard(
              onTap: () {
                Get.to(
                  () => const ProcessingScreen(),
                );
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
                    onTap: () {
                      Get.toNamed('/history');
                    },
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