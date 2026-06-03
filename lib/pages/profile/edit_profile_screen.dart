import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/buttons.dart';
import 'package:mediaid_ui/components/form_components.dart';
import 'package:mediaid_ui/components/profile_components.dart';
import 'package:mediaid_ui/components/top_bar.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),

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

              const CustomTextField(
                hintText: "Full Name",
                icon: Icons.person_outline_rounded,
              ),

              const SizedBox(height: 20),

              const CustomTextField(
                hintText: "Email Address",
                icon: Icons.email_outlined,
              ),

              const SizedBox(height: 20),

              const CustomTextField(
                hintText: "Phone Number",
                icon: Icons.phone_outlined,
              ),

              const SizedBox(height: 40),

              PrimaryButton(
                text: "Save Changes",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}