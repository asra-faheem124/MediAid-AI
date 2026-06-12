import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/components/buttons.dart';
import 'package:mediaid_ui/home_screen.dart';
import 'package:mediaid_ui/pages/firstAid/guide_screen.dart';
import 'package:mediaid_ui/pages/firstAid/history_screen.dart';
import 'package:mediaid_ui/pages/profile/profile_screen.dart';
import 'package:mediaid_ui/pages/firstScreens/welcome_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const HomeScreen(),
    const HistoryScreen(),
    const GuideScreen(),
    const ProfileScreen(),
  ];

  // ── Check if user is logged in ───────────────────────
  Future<bool> _isGuest() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isGuest') ?? false;
  }

  bool _isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  // ── Handle tab tap with access control ───────────────
  void onItemTapped(int index) async {
    // Home (0) and Guide (2) → always accessible
    if (index == 0 || index == 2) {
      setState(() => selectedIndex = index);
      return;
    }

    // History (1) and Profile (3) → logged in only
    final bool guest = await _isGuest();
    final bool loggedIn = _isLoggedIn();

    if (loggedIn && !guest) {
      // Logged in → allow access
      setState(() => selectedIndex = index);
    } else {
      // Guest → show login prompt
      _showLoginPrompt(index);
    }
  }

  // ── Login prompt bottom sheet ─────────────────────────
  void _showLoginPrompt(int attemptedIndex) {
    final String featureName = attemptedIndex == 1 ? "History" : "Profile";

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            // ── Handle bar ───────────────────────────────
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: ColorConstants.border,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 24),

            // ── Lock icon ────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorConstants.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.lock_outline_rounded,
                color: ColorConstants.primary,
                size: 32,
              ),
            ),

            const SizedBox(height: 16),

            // ── Title ────────────────────────────────────
            Text(
              "$featureName Requires Login",
              style: AppTextStyles.title,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            // ── Subtitle ─────────────────────────────────
            Text(
              "Create a free account to access $featureName and save your scan history.",
              style: AppTextStyles.lightBody,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 28),

            // ── Login button ─────────────────────────────
            PrimaryButton(
              text: "Login / Sign Up",
              onPressed: () {
                Get.back(); // close bottom sheet
                Get.offAll(() => const WelcomeScreen());
              },
            ),

            const SizedBox(height: 12),

            // ── Stay as guest ─────────────────────────────
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                "Continue as Guest",
                style: AppTextStyles.primaryText.copyWith(fontSize: 14),
              ),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        backgroundColor: ColorConstants.background,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        selectedItemColor: ColorConstants.primary,
        unselectedItemColor: ColorConstants.bodyText,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Guide',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}