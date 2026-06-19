// ============================================================
// emergency_screen.dart
// SOS screen — tapping "Call Emergency 112" opens the phone
// dialer with 112 pre-filled (user still taps call themselves —
// apps cannot auto-dial without special system permissions).
// ============================================================

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/components/top_bar.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  // ── Opens the native phone dialer with the number pre-filled ──
  Future<void> _callEmergencyNumber(BuildContext context) async {
    const String emergencyNumber = '112';
    final Uri dialUri = Uri(scheme: 'tel', path: emergencyNumber);

    try {
      final bool launched = await launchUrl(dialUri);
      if (!launched) {
        _showCallError(context);
      }
    } catch (e) {
      _showCallError(context);
    }
  }

  void _showCallError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Could not open phone dialer. Please dial 112 manually.'),
        backgroundColor: ColorConstants.danger,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),

          child: Column(
            children: [
              // ================= TOP BAR =================

              const TopBar(
                title: "Emergency Help",
                actionIcon: Icons.call,
              ),

              const SizedBox(height: 30),

              // ================= SOS CIRCLE =================

              Container(
                height: 120,
                width: 120,

                decoration: BoxDecoration(
                  color: ColorConstants.danger.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),

                child: Center(
                  child: Container(
                    height: 85,
                    width: 85,

                    decoration: const BoxDecoration(
                      color: ColorConstants.danger,
                      shape: BoxShape.circle,
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        const Icon(
                          Icons.sos_rounded,
                          color: ColorConstants.background,
                          size: 34,
                        ),

                        Text(
                          "SOS",
                          style: AppTextStyles.body(context).copyWith(
                            color: ColorConstants.background,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ================= TITLE =================

              Text(
                "Need immediate assistance?",
                style: AppTextStyles.subHeading(context).copyWith(
                  color: ColorConstants.heading,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              // ================= DESCRIPTION =================

              Text(
                "Contact emergency services or your nearest hospital.",
                style: AppTextStyles.body(context),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 35),

              // ================= CALL BUTTON =================

              SizedBox(
                width: double.infinity,
                height: 60,

                child: ElevatedButton.icon(
                  // 👇 Opens phone dialer with 112 pre-filled
                  onPressed: () => _callEmergencyNumber(context),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.danger,
                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  icon: const Icon(
                    Icons.call,
                    color: ColorConstants.background,
                  ),

                  label: Text(
                    "Call Emergency 112",
                    style: AppTextStyles.button,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ================= ACTION CARDS =================

              Row(
                children: [
                  Expanded(
                    child: EmergencyActionCard(
                      icon: Icons.contacts_rounded,
                      title: "Emergency\nContacts",
                      onTap: () {},
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: EmergencyActionCard(
                      icon: Icons.location_on_outlined,
                      title: "Nearest\nHospitals",
                      onTap: () {},
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // ================= WARNING TEXT =================

              Text(
                "Use only in real emergencies.",
                style: AppTextStyles.caption(context).copyWith(
                  color: ColorConstants.danger,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================
// ================= EMERGENCY ACTION CARD =================
// =========================================================

class EmergencyActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const EmergencyActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,

        child: Ink(
          padding: const EdgeInsets.symmetric(
            vertical: 22,
          ),

          decoration: BoxDecoration(
            color: ColorConstants.background,
            borderRadius: BorderRadius.circular(22),

            border: Border.all(
              color: ColorConstants.border,
            ),
          ),

          child: Column(
            children: [
              Icon(
                icon,
                color: ColorConstants.primary,
                size: 34,
              ),

              const SizedBox(height: 14),

              Text(
                title,
                style: AppTextStyles.body(context).copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}