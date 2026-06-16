import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/constants.dart';

class AppTextStyles {
  // ================= HEADINGS =================

  static TextStyle heading(BuildContext context) => TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).textTheme.titleLarge?.color,
        letterSpacing: 0.3,
      );

  static TextStyle title(BuildContext context) => TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).textTheme.titleLarge?.color,
      );

  static TextStyle subHeading(BuildContext context) => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      );

  // ================= BODY =================

  static TextStyle body(BuildContext context) => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).textTheme.bodyMedium?.color,
        height: 1.5,
      );

  static TextStyle lightBody(BuildContext context) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).hintColor,
        height: 1.4,
      );

  static TextStyle caption(BuildContext context) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).hintColor,
      );

  // ================= BUTTON =================

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle primaryText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: ColorConstants.primary,
  );

  // ================= STATUS =================

  static const TextStyle success = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: ColorConstants.success,
  );

  static const TextStyle warning = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: ColorConstants.warning,
  );

  static const TextStyle danger = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: ColorConstants.danger,
  );

  AppTextStyles(BuildContext context);
}