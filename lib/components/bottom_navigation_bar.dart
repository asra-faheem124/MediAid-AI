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

  Future<bool> _isGuest() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isGuest') ?? false;
  }

  bool _isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  void onItemTapped(int index) async {
    if (index == 0 || index == 2) {
      setState(() => selectedIndex = index);
      return;
    }

    final bool guest = await _isGuest();
    final bool loggedIn = _isLoggedIn();

    if (loggedIn && !guest) {
      setState(() => selectedIndex = index);
    } else {
      _showLoginPrompt(index);
    }
  }

  void _showLoginPrompt(int attemptedIndex) {
    final String featureName =
        attemptedIndex == 1 ? "History" : "Profile";

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final theme = Theme.of(context);

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle Bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 24),

              // Lock Icon
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

              // Title
              Text(
                "$featureName Requires Login",
                style: AppTextStyles.title(context),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              // Subtitle
              Text(
                "Create a free account to access $featureName and save your scan history.",
                style: AppTextStyles.lightBody(context),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 28),

              // Login Button
              PrimaryButton(
                text: "Login / Sign Up",
                onPressed: () {
                  Get.back();
                  Get.offAll(() => const WelcomeScreen());
                },
              ),

              const SizedBox(height: 12),

              // Guest Button
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  "Continue as Guest",
                  style: const TextStyle(
                    color: ColorConstants.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: pages[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        type: BottomNavigationBarType.fixed,

        showSelectedLabels: true,
        showUnselectedLabels: true,

        backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
        selectedItemColor:
            theme.bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor:
            theme.bottomNavigationBarTheme.unselectedItemColor,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_rounded),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: "Guide",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}