import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/home_screen.dart';
import 'package:mediaid_ui/processing_screen.dart';
import 'package:mediaid_ui/result_screen.dart';
import 'package:mediaid_ui/splash.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mediaid UI',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        scaffoldBackgroundColor: ColorConstants.background,
      ),
      home: ResultScreen(),
    );
  }
}
