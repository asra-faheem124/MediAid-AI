import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/components/top_bar.dart';
import 'package:mediaid_ui/controller/theme_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //  Get theme controller
  final ThemeController _themeController = Get.find<ThemeController>();

  bool notifications = true;
  bool voiceGuide = true;

  @override
  Widget build(BuildContext context) {
    final isDark = _themeController.isDarkMode.value;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            children: [
              const TopBar(
                title: "Settings",
                actionIcon: Icons.settings,
                showBackButton: true,
              ),

              const SizedBox(height: 30),

              // ── Notifications ────────────────────────
              SettingsTile(
                icon: Icons.notifications_outlined,
                title: "Notifications",
                value: notifications,
                onChanged: (value) {
                  setState(() => notifications = value);
                },
              ),

              const SizedBox(height: 18),

              //  Dark Mode — connected to ThemeController
              Obx(() => SettingsTile(
                icon: Icons.dark_mode_outlined,
                title: "Dark Mode",
                value: _themeController.isDarkMode.value,
                onChanged: (value) {
                  _themeController.toggleTheme();
                },
              )),

              const SizedBox(height: 18),

              // ── Voice Guidance ───────────────────────
              SettingsTile(
                icon: Icons.volume_up_outlined,
                title: "Voice Guidance",
                value: voiceGuide,
                onChanged: (value) {
                  setState(() => voiceGuide = value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// SETTINGS TILE
// ═══════════════════════════════════════════════════════
class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final Function(bool) onChanged;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface, // theme aware
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).dividerColor, // theme aware
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: ColorConstants.primary,
                size: 22,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: AppTextStyles.body(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).iconTheme.color, //  theme aware
                ),
              ),
            ],
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