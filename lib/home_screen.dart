import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/model/UserModel.dart';
import 'package:mediaid_ui/pages/auth/login_screen.dart';
import 'package:mediaid_ui/pages/firstAid/emergency_screen.dart';
import 'package:mediaid_ui/pages/firstAid/history_screen.dart';
import 'package:mediaid_ui/pages/firstAid/scan_screen.dart';
import 'package:mediaid_ui/pages/profile/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mediaid_ui/components/buttons.dart';
import 'package:mediaid_ui/components/cards.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/controller/AuthController.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ── Reads name from Firestore (source of truth for profile data) ──
  // Falls back to Auth's displayName, then "User" if neither exist.
  Future<String?> _fetchUserName(String uid) async {
    try {
      final doc =
          await FirebaseFirestore.instance.collection('User').doc(uid).get();
      if (doc.exists) {
        final userModel = Usermodel.fromMap(doc.data() as Map<String, dynamic>);
        if (userModel.name.isNotEmpty) return userModel.name;
      }
    } catch (e) {
      // Silently fall through to displayName/"User" fallback below
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final Authcontroller authController = Get.find<Authcontroller>();

    return FutureBuilder<bool>(
      future: _isGuest(),
      builder: (context, guestSnapshot) {
        final bool isGuest = guestSnapshot.data ?? false;

        return FutureBuilder<String?>(
          // Skip the Firestore call entirely for guests — no user to look up
          future: (isGuest || user == null)
              ? Future.value(null)
              : _fetchUserName(user.uid),
          builder: (context, nameSnapshot) {
            final String displayedName = isGuest
                ? "MediAid AI"
                : (nameSnapshot.data ??
                    user?.displayName ??
                    "User");

            final String initial = displayedName.isNotEmpty
                ? displayedName[0].toUpperCase()
                : "U";

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
                        // Greeting Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isGuest ? "Welcome to" : "Hello",
                              style: AppTextStyles.body(context),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              displayedName,
                              style: AppTextStyles.title(context),
                            ),
                          ],
                        ),

                        // LOGIN or AVATAR MENU
                        isGuest
                            ? SizedBox(
                                width: 100,
                                height: 40,
                                child: SecondaryButtons(
                                  text: "Login",
                                  onPressed: () {
                                    Get.offAll(() => LoginScreen());
                                  },
                                ),
                              )
                            : PopupMenuButton<String>(
                                offset: const Offset(0, 55),
                                color: Theme.of(context).scaffoldBackgroundColor,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: BorderSide(
                                    color: Theme.of(context).dividerColor,
                                    width: 1,
                                  ),
                                ),
                                icon: CircleAvatar(
                                  radius: 22,
                                  backgroundColor: ColorConstants.primary,
                                  child: Text(initial, style: AppTextStyles.button),
                                ),
                                onSelected: (value) async {
                                  switch (value) {
                                    case "profile":
                                      Get.to(() => ProfileScreen());
                                      break;
                                    case "history":
                                      Get.to(() => HistoryScreen());
                                      break;
                                    case "logout":
                                      await authController.logout();
                                      break;
                                  }
                                },
                                itemBuilder: (context) => [
                                  _buildMenuItem(
                                    context: context,
                                    value: "profile",
                                    icon: Icons.person_outline,
                                    title: "Profile",
                                  ),
                                  _buildMenuItem(
                                    context: context,
                                    value: "history",
                                    icon: Icons.history,
                                    title: "Scan History",
                                  ),
                                  const PopupMenuDivider(height: 8),
                                  _buildMenuItem(
                                    context: context,
                                    value: "logout",
                                    icon: Icons.logout,
                                    title: "Logout",
                                    isDestructive: true,
                                  ),
                                ],
                              ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    Text(
                      "How can we help you today?",
                      style: AppTextStyles.body(context),
                    ),

                    const SizedBox(height: 24),

                    // ================= SCAN CARD =================
                    ScanCard(
                      onTap: () {
                        Get.to(() => ScanScreen());
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
                              Get.to(() => HistoryScreen());
                            },
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: ActionCard(
                            icon: Icons.notifications_active_outlined,
                            title: "Emergency",
                            iconColor: ColorConstants.danger,
                            onTap: () {
                              Get.to(const EmergencyScreen());
                            },
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
      },
    );
  }

  // ================= GUEST CHECK =================
  Future<bool> _isGuest() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isGuest') ?? false;
  }
}

// ================= POPUP MENU ITEM BUILDER =================

PopupMenuItem<String> _buildMenuItem({
  required BuildContext context,
  required String value,
  required IconData icon,
  required String title,
  bool isDestructive = false,
}) {
  return PopupMenuItem<String>(
    value: value,
    child: Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: isDestructive
              ? ColorConstants.danger
              : ColorConstants.primaryDark,
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: AppTextStyles.body(context).copyWith(
            color: isDestructive
                ? ColorConstants.danger
                : Theme.of(context).primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}