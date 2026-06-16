import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/text_styles.dart';

class AppSnackbar {
  // ================= SUCCESS =================

  static void success(BuildContext context, String message) {
    _showGlassSnackBar(
      context: context,
      message: message,
      icon: Icons.check_circle_outline_rounded,
      iconColor: const Color(0xFF22C55E),
    );
  }

  // ================= ERROR =================

  static void error(BuildContext context, String message) {
    _showGlassSnackBar(
      context: context,
      message: message,
      icon: Icons.error_outline_rounded,
      iconColor: const Color(0xFFEF4444),
    );
  }

  // ================= CORE GLASS SNACKBAR =================

  static void _showGlassSnackBar({
    required BuildContext context,
    required String message,
    required IconData icon,
    required Color iconColor,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),

        content: ClipRRect(
          borderRadius: BorderRadius.circular(18),

          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 16,
              sigmaY: 16,
            ),

            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),

              decoration: BoxDecoration(
                color: isDark
                    ? theme.cardColor.withValues(alpha: 0.90)
                    : Colors.white.withValues(alpha: 0.90),

                borderRadius: BorderRadius.circular(18),

                border: Border.all(
                  color: theme.dividerColor,
                  width: 1,
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: isDark ? 0.25 : 0.08,
                    ),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),

              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),

                    decoration: BoxDecoration(
                      color: iconColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Icon(
                      icon,
                      size: 20,
                      color: iconColor,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      message,
                      style: AppTextStyles.body(context).copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}