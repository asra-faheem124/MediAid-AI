import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/app_theme.dart';
import 'package:mediaid_ui/controller/AuthController.dart';
import 'package:mediaid_ui/controller/ScanController.dart';
import 'package:mediaid_ui/controller/theme_controller.dart';
import 'package:mediaid_ui/firebase_options.dart';
import 'package:mediaid_ui/pages/firstScreens/splash.dart';
import 'package:mediaid_ui/services/AuthService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Register all controllers globally
  Get.put(Authservice());
  Get.put(Authcontroller());
  Get.put(ScanController());
  Get.put(ThemeController()); 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'Mediaid AI',

      // Replace theme with both light and dark
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light, // default, controller overrides this

      home: const SplashScreen(),
    );
  }
}