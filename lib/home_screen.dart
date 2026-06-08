import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mediaid_ui/components/buttons.dart';
import 'package:mediaid_ui/components/cards.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/controller/AuthController.dart';
import 'package:mediaid_ui/pages/firstAid/processing_screen.dart';
import 'package:mediaid_ui/pages/firstScreens/welcome_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final Authcontroller authController = Get.find<Authcontroller>();

    // ✅ Detect guest mode from shared prefs
    // We use a FutureBuilder to read guest state
    return FutureBuilder<bool>(
      future: _isGuest(),
      builder: (context, snapshot) {
        final bool isGuest = snapshot.data ?? false;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                          isGuest ? "Welcome to" : "Hello",
                          style: AppTextStyles.body,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isGuest
                              ? "MediAid AI"
                              : (user?.displayName ?? "User"),
                          style: AppTextStyles.title,
                        ),
                      ],
                    ),

                    // ✅ Guest → show Login button
                    // ✅ Logged in → show avatar + menu
                    isGuest
                        ? SizedBox(
                            width: 120,
                            child: SecondaryButtons(
                              text: "Login",
                              onPressed: () {
                                Get.offAll(() => const WelcomeScreen());
                              },
                            ),
                          )
                        : PopupMenuButton<String>(
                            offset: const Offset(0, 50),
                            icon: CircleAvatar(
                              radius: 22,
                              backgroundColor: ColorConstants.primary,
                              child: Text(
                                user?.displayName != null &&
                                        user!.displayName!.isNotEmpty
                                    ? user.displayName![0].toUpperCase()
                                    : "U",
                                style: AppTextStyles.button,
                              ),
                            ),
                            onSelected: (value) async {
                              switch (value) {
                                case "profile":
                                  // Get.to(() => ProfileScreen());
                                  break;
                                case "history":
                                  // Get.to(() => HistoryScreen());
                                  break;
                                case "logout":
                                  // ✅ Uses controller logout (clears session)
                                  await authController.logout();
                                  break;
                              }
                            },
                            itemBuilder: (context) => const [
                              PopupMenuItem(
                                value: "profile",
                                child: Text("Profile"),
                              ),
                              PopupMenuItem(
                                value: "history",
                                child: Text("Scan History"),
                              ),
                              PopupMenuItem(
                                value: "logout",
                                child: Text("Logout"),
                              ),
                            ],
                          ),
                  ],
                ),

                const SizedBox(height: 24),

                Text("How can we help you today?", style: AppTextStyles.body),

                const SizedBox(height: 24),

                // ================= SCAN CARD =================
                ScanCard(
                  onTap: () {
                    Get.to(() => const ProcessingScreen());
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
                          // Get.to(() => HistoryScreen());
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
      },
    );
  }

  // ✅ Read guest state from shared preferences
  Future<bool> _isGuest() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isGuest') ?? false;
  }
}
