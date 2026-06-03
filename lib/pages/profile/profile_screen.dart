import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/profile_components.dart';
import 'package:mediaid_ui/components/top_bar.dart';
import 'package:mediaid_ui/pages/profile/medical_info_screen.dart';
import 'package:mediaid_ui/pages/profile/edit_profile_screen.dart';
import 'package:mediaid_ui/pages/profile/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return const Scaffold(body: Center(child: Text("No user logged in")));
    }

    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('User')
            .doc(currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // No data found
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('User data not found'));
          }

          // User Data
          final user = snapshot.data!.data() as Map<String, dynamic>;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Column(
                children: [
                  // ================= TOP BAR =================
                  const TopBar(
                    title: "Profile",
                    actionIcon: Icons.account_circle_outlined,
                    showBackButton: false,
                  ),

                  const SizedBox(height: 30),

                  // ================= PROFILE CARD =================
                  ProfileHeaderCard(
                    name: user['name'] ?? '',
                    email: user['email'] ?? '',
                    // imageUrl: user['profileImage'] ?? '',
                  ),

                  const SizedBox(height: 30),

                  // ================= MENU ITEMS =================
                  ProfileMenuTile(
                    icon: Icons.person_outline_rounded,
                    title: "Edit Profile",
                    onTap: () => Get.to(() => const EditProfileScreen()),
                  ),

                  const SizedBox(height: 16),

                  ProfileMenuTile(
                    icon: Icons.medical_information_outlined,
                    title: "Medical Information",
                    onTap: () => Get.to(() => const MedicalInfoScreen()),
                  ),

                  const SizedBox(height: 16),

                  ProfileMenuTile(
                    icon: Icons.settings_outlined,
                    title: "Settings",
                    onTap: () => Get.to(() => const SettingsScreen()),
                  ),

                  const SizedBox(height: 16),

                  ProfileMenuTile(
                    icon: Icons.logout_rounded,
                    title: "Logout",
                    iconColor: ColorConstants.danger,
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
