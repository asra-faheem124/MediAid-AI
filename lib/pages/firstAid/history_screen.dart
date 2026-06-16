import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/components/top_bar.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),

          child: Column(
            children: [
              // ================= TOP BAR =================
              const TopBar(title: "History", actionIcon: Icons.delete),

              const SizedBox(height: 24),

              // ================= HISTORY LIST =================
              Align(
                alignment: Alignment.centerLeft,

                child: Text(
                  "Recent Histories",
                  style: AppTextStyles.subHeading(context),
                ),
              ),
              const SizedBox(height: 24),

              Expanded(
                child: ListView(
                  children: const [
                    HistoryCard(
                      injury: "Burn",
                      date: "Today, 10:45 AM",
                      severity: "High",
                      icon: "🔥",
                    ),

                    SizedBox(height: 16),

                    HistoryCard(
                      injury: "Cut Injury",
                      date: "Yesterday, 5:30 PM",
                      severity: "Medium",
                      icon: "🩹",
                    ),

                    SizedBox(height: 16),

                    HistoryCard(
                      injury: "Bruise",
                      date: "May 8, 2:15 PM",
                      severity: "Low",
                      icon: "💥",
                    ),

                    SizedBox(height: 16),

                    HistoryCard(
                      injury: "Sprain",
                      date: "May 6, 8:20 PM",
                      severity: "Medium",
                      icon: "🦶",
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
// ===================== HISTORY CARD ======================
// =========================================================

class HistoryCard extends StatelessWidget {
  final String injury;
  final String date;
  final String severity;
  final String icon;

  const HistoryCard({
    super.key,
    required this.injury,
    required this.date,
    required this.severity,
    required this.icon,
  });

  Color getSeverityColor() {
    switch (severity.toLowerCase()) {
      case "high":
        return ColorConstants.danger;

      case "medium":
        return ColorConstants.warning;

      default:
        return ColorConstants.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color:  Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(22),

        border: Border.all(color: Theme.of(context).dividerColor),
      ),

      child: Row(
        children: [
          // ================= ICON =================
          Container(
            height: 58,
            width: 58,

            decoration: BoxDecoration(
              color: getSeverityColor().withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(18),
            ),

            child: Center(
              child: Text(icon, style: const TextStyle(fontSize: 28)),
            ),
          ),

          const SizedBox(width: 16),

          // ================= CONTENT =================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  injury,
                  style: AppTextStyles.subHeading(context)
                ),

                const SizedBox(height: 5),

                Text(date, style: AppTextStyles.body(context).copyWith(fontSize: 12)),
              ],
            ),
          ),

          // ================= SEVERITY BADGE =================
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),

            decoration: BoxDecoration(
              color: getSeverityColor().withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(30),
            ),

            child: Text(
              severity,

              style: AppTextStyles.caption(context).copyWith(
                color: getSeverityColor(),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
