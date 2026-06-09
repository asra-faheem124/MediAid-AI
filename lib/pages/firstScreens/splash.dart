import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mediaid_ui/pages/firstScreens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mediaid_ui/components/bottom_navigation_bar.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // Animated loading bar width (0.0 → 1.0)
  double _loadingProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _startLoadingAnimation();

    // Navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      _decideNavigation();
    });
  }

  // Animate the loading bar smoothly
  void _startLoadingAnimation() {
    Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _loadingProgress += 0.01;
        if (_loadingProgress >= 1.0) {
          _loadingProgress = 1.0;
          timer.cancel();
        }
      });
    });
  }

  Future<void> _decideNavigation() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Get.offAll(() => BottomNavBar());
      return;
    }

    // No Firebase session → check if offline but was logged in before
    final prefs = await SharedPreferences.getInstance();
    final bool wasLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final bool wasGuest = prefs.getBool('isGuest') ?? false;

    // Check connectivity
    final connectivityResult = await Connectivity().checkConnectivity();
    final bool isOffline = connectivityResult == ConnectivityResult.none;

    if (isOffline && wasLoggedIn) {
      // Was logged in before, now offline → trust cached session, go home
      Get.offAll(() => BottomNavBar());
    } else if (wasGuest) {
      // Was using as guest → go directly home (guests always go home)
      Get.offAll(() => BottomNavBar());
    } else {
      // New user or logged out → show onboarding
      Get.offAll(() => WelcomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,

      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                color: ColorConstants.primary.withValues(alpha: 0.2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(120),
                  topRight: Radius.circular(120),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: -20,
            left: -40,
            child: Container(
              width: 240,
              height: 120,
              decoration: BoxDecoration(
                color: ColorConstants.primary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),

          Positioned(
            bottom: -25,
            right: -30,
            child: Container(
              width: 230,
              height: 120,
              decoration: BoxDecoration(
                color: ColorConstants.primaryLight.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          // main content
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Box
                  Container(
                    width: 125,
                    height: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstants.primaryLight.withValues(alpha: 0.5),
                          blurRadius: 25,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        "assets/images/Mediaid AI Logo.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  const Text(
                    "MediAid AI",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.primary,
                      letterSpacing: 0.5,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Smart First Aid Assistant",
                    style: AppTextStyles.subHeading,
                  ),

                  const SizedBox(height: 60),

                  // Animated Loading Bar
                  Container(
                    width: 120,
                    height: 6,
                    decoration: BoxDecoration(
                      color: ColorConstants.border,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 30),
                        width: 120 * _loadingProgress, // dynamic width
                        decoration: BoxDecoration(
                          color: ColorConstants.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}