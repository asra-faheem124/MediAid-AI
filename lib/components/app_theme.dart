import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediaid_ui/components/constants.dart';

class AppTheme {
  // ════════════════════════════════════════════════════
  // LIGHT THEME
  // ════════════════════════════════════════════════════
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorConstants.background,
    primaryColor: ColorConstants.primary,
    textTheme: GoogleFonts.poppinsTextTheme(),

    colorScheme: const ColorScheme.light(
      primary: ColorConstants.primary,
      surface: ColorConstants.background,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: ColorConstants.background,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorConstants.heading),
    ),

    cardTheme: CardThemeData(
      color: ColorConstants.background,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: ColorConstants.border),
      ),
    ),

    dividerColor: ColorConstants.border,

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ColorConstants.background,
      selectedItemColor: ColorConstants.primary,
      unselectedItemColor: ColorConstants.bodyText,
    ),

    iconTheme: const IconThemeData(color: ColorConstants.heading),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: ColorConstants.background,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: ColorConstants.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: ColorConstants.primary, width: 1.5),
      ),
    ),
  );

  // ════════════════════════════════════════════════════
  // DARK THEME
  // ════════════════════════════════════════════════════
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorConstants.darkBackground,
    primaryColor: ColorConstants.primary,
    hintColor: ColorConstants.darkLightText, //  for lightBody + caption
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    colorScheme: const ColorScheme.dark(
      primary: ColorConstants.primary,
      surface: ColorConstants.darkSurface,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorConstants.darkBackground,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorConstants.darkHeading),
    ),
    cardTheme: CardThemeData(
      color: ColorConstants.darkCard, //  cards go dark
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: ColorConstants.darkBorder),
      ),
    ),
    dividerColor: ColorConstants.darkBorder, //  borders go dark
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ColorConstants.darkSurface, //  bottom bar goes dark
      selectedItemColor: ColorConstants.primary,
      unselectedItemColor: ColorConstants.darkBodyText,
    ),
    iconTheme: const IconThemeData(color: ColorConstants.darkHeading),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: ColorConstants.darkCard, //  text fields go dark
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: ColorConstants.darkBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: ColorConstants.primary, width: 1.5),
      ),
    ),
  );
}
