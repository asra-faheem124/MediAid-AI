import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/constants.dart';

class AppTextStyles {

  // Main Headings
  static const TextStyle heading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: ColorConstants.heading,
    letterSpacing: 0.3,
  );

  // Screen Titles
  static const TextStyle title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: ColorConstants.heading,
  );

  // Card Titles / Medium Heading
  static const TextStyle subHeading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: ColorConstants.bodyText,
  );

  // Main Body Text
  static const TextStyle body = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: ColorConstants.bodyText,
    height: 1.5,
  );

  // Light Description Text
  static const TextStyle lightBody = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ColorConstants.lightText,
    height: 1.4,
  );

  // Small Caption Text
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorConstants.lightText,
  );

  // Button Text
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Primary Colored Text
  static const TextStyle primaryText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: ColorConstants.primary,
  );

  // Success Text
  static const TextStyle success = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: ColorConstants.success,
  );

  // Warning Text
  static const TextStyle warning = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: ColorConstants.warning,
  );

  // Danger Text
  static const TextStyle danger = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: ColorConstants.danger,
  );
}
