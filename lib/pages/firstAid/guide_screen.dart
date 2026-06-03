import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/components/top_bar.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),

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

              Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),

                  border: Border.all(
                    color: ColorConstants.border,
                  ),
                ),

                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: ColorConstants.lightText,
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search injuries or treatments...",
                          hintStyle: AppTextStyles.lightBody,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              // ================= CATEGORY TITLE =================

              Text(
                "Emergency Categories",
                style: AppTextStyles.subHeading.copyWith(
                  color: ColorConstants.heading,
                ),
              ),

              const SizedBox(height: 18),

              // ================= CATEGORY GRID =================

              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,

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

// =========================================================
// ================= CATEGORY CARD =========================
// =========================================================

class GuideCategoryCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;

  const GuideCategoryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),

        border: Border.all(
          color: ColorConstants.border,
        ),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          // ================= ICON =================

          Container(
            height: 70,
            width: 70,

            decoration: BoxDecoration(
              color: ColorConstants.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),

            child: Center(
              child: Text(
                icon,
                style: const TextStyle(fontSize: 32),
              ),
            ),
          ),

          const SizedBox(height: 18),

          // ================= TITLE =================

          Text(
            title,

            style: AppTextStyles.subHeading.copyWith(
              color: ColorConstants.heading,
              fontSize: 17,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 6),

          // ================= SUBTITLE =================

          Text(
            subtitle,

            style: AppTextStyles.lightBody.copyWith(
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}