import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/components/top_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;
  bool darkMode = false;
  bool voiceGuide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),

          child: Column(
            children: [
              const TopBar(
                title: "Settings",
                actionIcon: Icons.settings,
                showBackButton: true,
              ),

              const SizedBox(height: 30),

              SettingsTile(
                title: "Notifications",
                value: notifications,
                onChanged: (value) {
                  setState(() {
                    notifications = value;
                  });
                },
              ),

              const SizedBox(height: 18),

              SettingsTile(
                title: "Dark Mode",
                value: darkMode,
                onChanged: (value) {
                  setState(() {
                    darkMode = value;
                  });
                },
              ),

              const SizedBox(height: 18),

              SettingsTile(
                title: "Voice Guidance",
                value: voiceGuide,
                onChanged: (value) {
                  setState(() {
                    voiceGuide = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================
// ==================== SETTINGS TILE ======================
// =========================================================

class SettingsTile extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool) onChanged;

  const SettingsTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 8,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        border: Border.all(
          color: ColorConstants.border,
        ),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(
            title,
            style: AppTextStyles.body.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          Switch(
            value: value,
            activeColor: ColorConstants.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}