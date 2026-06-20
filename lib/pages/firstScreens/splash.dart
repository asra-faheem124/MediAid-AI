import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mediaid_ui/controller/AuthController.dart';
import 'package:mediaid_ui/pages/auth/furtherInfo.dart';
import 'package:mediaid_ui/pages/firstScreens/onboarding_one.dart';
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
  }

  // Animate loading bar AND navigate when complete
  void _startLoadingAnimation() {
    Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        _loadingProgress += 0.02; // faster & smoother

        if (_loadingProgress >= 1.0) {
          _loadingProgress = 1.0;
          timer.cancel();

          // Navigate ONLY when loading finishes
          _decideNavigation();
        }
      });
    });
  }

  Future<void> _decideNavigation() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();

    // ✅ Check app-level onboarding (intro slides) first — highest priority.
    // This is the "have they ever opened the app before" flag — separate
    // from the per-account "have they filled location/contacts" flag below.
    final bool onboardingSeen = prefs.getBool('onboardingSeen') ?? false;

    if (!onboardingSeen) {
      // Fresh install → show intro/welcome onboarding slides
      Get.offAll(() => const OnboardingScreenOne());
      return;
    }

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // 👇 FIX: don't assume a logged-in session means onboarding
      // (location + emergency contacts) was completed. Check Firestore.
      await _routeLoggedInUser(user.uid);
      return;
    }

    // No Firebase session → check if offline but was logged in before
    final bool wasLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final bool wasGuest = prefs.getBool('isGuest') ?? false;

    // Check connectivity
    final connectivityResult = await Connectivity().checkConnectivity();
    final bool isOffline = connectivityResult == ConnectivityResult.none;

    if (isOffline && wasLoggedIn) {
      // Was logged in before, now offline → trust cached session, go home.
      // (Can't check Firestore offline, so we assume onboarding was done
      // previously — this only triggers for returning sessions, not new ones.)
      Get.offAll(() => BottomNavBar());
    } else if (wasGuest) {
      // Was using as guest → go directly home (guests skip onboarding entirely)
      Get.offAll(() => BottomNavBar());
    } else {
      // New user or logged out → show welcome/login screen
      Get.offAll(() => WelcomeScreen());
    }
  }

  // ── Routes a logged-in user based on their onboarding status ───
  Future<void> _routeLoggedInUser(String uid) async {
    try {
      final Authcontroller authController = Get.find<Authcontroller>();
      final bool completed = await authController.hasCompletedOnboarding(uid);

      if (completed) {
        Get.offAll(() => BottomNavBar());
      } else {
        Get.offAll(() => const Furtherinfo());
      }
    } catch (e) {
      // Authcontroller not registered yet, or Firestore check failed —
      // fail safe to BottomNavBar rather than blocking the user entirely.
      Get.offAll(() => BottomNavBar());
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
                    width: 155,
                    height: 155,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstants.primaryLight.withValues(
                            alpha: 0.3,
                          ),
                          blurRadius: 25,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset("assets/images/Mediaid AI Logo.png"),
                    ),
                  ),

                  const SizedBox(height: 35),

                   Text(
                    "Smart First Aid Assistant",
                    style: AppTextStyles.subHeading(context).copyWith(color: ColorConstants.heading),
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
                        duration: const Duration(milliseconds: 20),
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