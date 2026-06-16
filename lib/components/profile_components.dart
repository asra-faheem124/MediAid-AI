import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';

class ProfileHeaderCard extends StatelessWidget {
  final String name;
  final String email;
  // final String imageUrl;
  const ProfileHeaderCard({
    super.key,
    required this.name,
    required this.email,
    // required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: ColorConstants.primary,
        borderRadius: BorderRadius.circular(28),
      ),

      child: Column(
        children: [
          Container(
            height: 90,
            width: 90,

            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),

            child: const Icon(Icons.person, color: Colors.white, size: 46),
          ),

          const SizedBox(height: 16),

          Text(
            name,
            style: AppTextStyles.subHeading(context).copyWith(
              color: Colors.white,
              fontSize: 22,
            ),
          ),

          const SizedBox(height: 6),

          Text(
          email,
            style: AppTextStyles.body(context).copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================
// ==================== PROFILE TILE =======================
// =========================================================

class ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color iconColor;

  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor = ColorConstants.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,

        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),

          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),

            border: Border.all(
  color: Theme.of(context).dividerColor,
),
          ),

          child: Row(
            children: [
              Icon(icon, color: iconColor),

              const SizedBox(width: 16),

              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.body(context).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
                color: ColorConstants.lightText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================
// ================= PROFILE IMAGE PICKER ==================
// =========================================================

class ProfileImagePicker extends StatelessWidget {
  const ProfileImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 110,
          width: 110,

          decoration: BoxDecoration(
            color: ColorConstants.primary.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),

          child: const Icon(
            Icons.person,
            size: 56,
            color: ColorConstants.primary,
          ),
        ),

        Positioned(
          bottom: 0,
          right: 0,

          child: Container(
            padding: const EdgeInsets.all(8),

            decoration: const BoxDecoration(
              color: ColorConstants.primary,
              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.camera_alt_outlined,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
