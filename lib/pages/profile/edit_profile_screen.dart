import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/buttons.dart';
import 'package:mediaid_ui/components/form_components.dart';
import 'package:mediaid_ui/components/profile_components.dart';
import 'package:mediaid_ui/components/top_bar.dart';
import 'package:mediaid_ui/controller/UserController.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final AuthController authController = Get.put(AuthController());

  void initState() {
    super.initState();
    authController.fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),

          child: Column(
            children: [
              const TopBar(
                title: "Edit Profile",
                actionIcon: Icons.check,
                showBackButton: true,
              ),

              const SizedBox(height: 30),

              const ProfileImagePicker(),

              const SizedBox(height: 30),

              CustomTextField(
                hintText: "Full Name",
                icon: Icons.person_outline_rounded,
                controller: authController.nameController,
              ),

              const SizedBox(height: 20),

              CustomTextField(
                hintText: "Email Address",
                icon: Icons.email_outlined,
                controller: authController.emailController,
              ),

              const SizedBox(height: 20),

              const CustomTextField(
                hintText: "Phone Number",
                icon: Icons.phone_outlined,
              ),

              const SizedBox(height: 40),

              PrimaryButton(
                text: "Save Changes",
                onPressed: () async {
                  await authController.updateUser();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
