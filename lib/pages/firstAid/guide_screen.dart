import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/cards.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/form_components.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/components/top_bar.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // ================= TOP BAR =================
              const TopBar(
                title: "First Aid Guide",
                actionIcon: Icons.menu_book_outlined,
              ),

              const SizedBox(height: 24),

              // ================= SEARCH =================
              SearchTextField(hintText: "Search injuries or treatments..."),

              SizedBox(height: 26),

              // ================= CATEGORY TITLE =================
              Text(
                "Emergency Categories",
                style: AppTextStyles.subHeading(context),
              ),

              const SizedBox(height: 18),

              // ================= CATEGORY GRID =================
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,

                  children: const [
                    GuideCategoryCard(
                      icon: "🔥",
                      title: "Burns",
                      subtitle: "Heat & fire injuries",
                    ),

                    GuideCategoryCard(
                      icon: "🩹",
                      title: "Cuts",
                      subtitle: "Bleeding injuries",
                    ),

                    GuideCategoryCard(
                      icon: "🦴",
                      title: "Fractures",
                      subtitle: "Bone injuries",
                    ),

                    GuideCategoryCard(
                      icon: "⚡",
                      title: "Electric Shock",
                      subtitle: "Power accidents",
                    ),

                    GuideCategoryCard(
                      icon: "🫁",
                      title: "Choking",
                      subtitle: "Breathing emergency",
                    ),

                    GuideCategoryCard(
                      icon: "💊",
                      title: "Poisoning",
                      subtitle: "Toxic substances",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
