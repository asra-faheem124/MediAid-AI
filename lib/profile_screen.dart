import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/profile_components.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/components/top_bar.dart';
import 'package:mediaid_ui/edit_profile_screen.dart';
import 'package:mediaid_ui/medical_info_screen.dart';
import 'package:mediaid_ui/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),

          child: Column(
            children: [
              // ================= TOP BAR =================
              const TopBar(
                title: "Profile",
                actionIcon: Icons.account_circle_outlined,
              ),

              const SizedBox(height: 30),

              // ================= PROFILE CARD =================
              const ProfileHeaderCard(),

              const SizedBox(height: 30),

              // ================= MENU ITEMS =================
              ProfileMenuTile(
                icon: Icons.person_outline_rounded,
                title: "Edit Profile",
                onTap: () => Get.to(const EditProfileScreen()),
              ),

              const SizedBox(height: 16),

              ProfileMenuTile(
                icon: Icons.medical_information_outlined,
                title: "Medical Information",
                onTap: () => Get.to(const MedicalInfoScreen()),
              ),

              const SizedBox(height: 16),

              ProfileMenuTile(
                icon: Icons.settings_outlined,
                title: "Settings",
                onTap: () => Get.to(const SettingsScreen()),
              ),

              const SizedBox(height: 16),

              ProfileMenuTile(
                icon: Icons.logout_rounded,
                title: "Logout",
                iconColor: ColorConstants.danger,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
