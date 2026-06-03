import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/buttons.dart';
import 'package:mediaid_ui/components/form_components.dart';
import 'package:mediaid_ui/components/top_bar.dart';

class MedicalInfoScreen extends StatelessWidget {
  const MedicalInfoScreen({super.key});

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
                title: "Medical Information",
                actionIcon: Icons.health_and_safety_outlined,
                showBackButton: true,
              ),

              const SizedBox(height: 30),

              const CustomTextField(
                hintText: "Blood Group",
                icon: Icons.bloodtype_outlined,
              ),

              const SizedBox(height: 20),

              const CustomTextField(
                hintText: "Allergies",
                icon: Icons.warning_amber_rounded,
              ),

              const SizedBox(height: 20),

              const CustomTextField(
                hintText: "Medical Conditions",
                icon: Icons.medical_information_outlined,
              ),

              const SizedBox(height: 20),

              const CustomTextField(
                hintText: "Emergency Contact",
                icon: Icons.call_outlined,
              ),

              const SizedBox(height: 40),

              PrimaryButton(
                text: "Save Information",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}