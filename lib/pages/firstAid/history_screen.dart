import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/components/top_bar.dart';
import 'package:mediaid_ui/controller/history_controller.dart';
import 'package:mediaid_ui/model/history_model.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HistoryController controller = Get.put(HistoryController());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [

              // ================= TOP BAR =================
              TopBar(
                title: "History",
                actionIcon: Icons.delete,
                onActionTap: () => _confirmDeleteAll(context, controller),
              ),

              const SizedBox(height: 24),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Recent Scans",
                  style: AppTextStyles.subHeading(context),
                ),
              ),

              const SizedBox(height: 16),

              // ================= CONTENT =================
              Expanded(
                child: Obx(() {

                  // Loading state
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ColorConstants.primary,
                      ),
                    );
                  }

                  // Empty state
                  if (controller.historyList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: ColorConstants.primary.withValues(
                                alpha: 0.08,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.history_rounded,
                              size: 52,
                              color: ColorConstants.primary,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "No scans yet",
                            style: AppTextStyles.subHeading(context),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Your scan history will appear here\nafter you scan an injury.",
                            style: AppTextStyles.lightBody(context),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  // History list
                  return RefreshIndicator(
                    color: ColorConstants.primary,
                    // onRefresh: () => controller.fetchHistory(),
                     onRefresh: () async {
                      await Future.delayed(const Duration(milliseconds: 500));
                    },

                    child: ListView.separated(
                      itemCount: controller.historyList.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        final item = controller.historyList[index];
                        return HistoryCard(
                          item: item,
                          onDelete: () => _confirmDelete(
                            context,
                            controller,
                            item,
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Confirm delete single ─────────────────────────────
  void _confirmDelete(
    BuildContext context,
    HistoryController controller,
    HistoryModel item,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).cardTheme.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text("Delete Scan?", style: AppTextStyles.title(context)),
        content: Text(
          "Remove this ${item.injury} scan from history?",
          style: AppTextStyles.body(context),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              "Cancel",
              style: TextStyle(color: ColorConstants.primary),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.deleteScan(item.id);
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: ColorConstants.danger),
            ),
          ),
        ],
      ),
    );
  }

  // ── Confirm delete all ────────────────────────────────
  void _confirmDeleteAll(
    BuildContext context,
    HistoryController controller,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).cardTheme.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text("Clear All History?", style: AppTextStyles.title(context)),
        content: Text(
          "This will permanently delete all your scan history.",
          style: AppTextStyles.body(context),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              "Cancel",
              style: TextStyle(color: ColorConstants.primary),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.deleteAll();
            },
            child: const Text(
              "Clear All",
              style: TextStyle(color: ColorConstants.danger),
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================
// ===================== HISTORY CARD ======================
// =========================================================
class HistoryCard extends StatelessWidget {
  final HistoryModel item;
  final VoidCallback onDelete;

  const HistoryCard({
    super.key,
    required this.item,
    required this.onDelete,
  });

  Color _severityColor() {
    switch (item.severity.toLowerCase()) {
      case 'severe':
        return ColorConstants.danger;
      case 'moderate':
        return ColorConstants.warning;
      case 'mild':
        return ColorConstants.success;
      default:
        return ColorConstants.primary;
    }
  }

  String _severityLabel() {
    switch (item.severity.toLowerCase()) {
      case 'severe':   return 'Severe';
      case 'moderate': return 'Moderate';
      case 'mild':     return 'Mild';
      default:         return 'None';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: ColorConstants.danger.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(22),
        ),
        child: const Icon(
          Icons.delete_outline_rounded,
          color: ColorConstants.danger,
          size: 28,
        ),
      ),
      confirmDismiss: (_) async {
        onDelete();
        return false; // controller handles removal
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Row(
          children: [

            // ── Emoji icon ──────────────────────────────
            Container(
              height: 58,
              width: 58,
              decoration: BoxDecoration(
                color: _severityColor().withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(
                  item.injuryEmoji,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // ── Info ────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.injury,
                    style: AppTextStyles.subHeading(context),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.formattedDate,
                    style: AppTextStyles.body(context).copyWith(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.confidencePercent,
                    style: AppTextStyles.caption(context).copyWith(
                      color: ColorConstants.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // ── Severity badge ──────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: _severityColor().withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                _severityLabel(),
                style: AppTextStyles.caption(context).copyWith(
                  color: _severityColor(),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
