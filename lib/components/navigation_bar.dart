import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/home_screen.dart';

class Navigationbar extends StatefulWidget {
  const Navigationbar({super.key});

  @override
  State<Navigationbar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    HomeScreen(),
    Text('History'),
    Text('Guide'),
    Text('Profile'),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Check login state
    // User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: pages[selectedIndex],

      // ✅ If logged in → show BottomNavBar, else → empty SizedBox
      // bottomNavigationBar: user == null
      bottomNavigationBar:
          // ? const SizedBox.shrink() // nothing shown if not logged in
          BottomNavigationBar(
            showSelectedLabels: true,
            backgroundColor: ColorConstants.background,
            currentIndex: selectedIndex,
            onTap: onItemTapped,
            selectedItemColor: ColorConstants.primary,
            unselectedItemColor: ColorConstants.bodyText,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
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
