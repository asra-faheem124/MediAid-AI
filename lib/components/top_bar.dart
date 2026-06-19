import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/text_styles.dart';

class TopBar extends StatelessWidget {
  final String title;
  final IconData? actionIcon;
  final bool showBackButton;
  final VoidCallback? onActionTap;

  const TopBar({
    super.key,
    required this.title,
    this.actionIcon,
    this.showBackButton = false,
    this.onActionTap,

  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back Button
        if (showBackButton)
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          )
        else
          const SizedBox(width: 48), // placeholder to align title
        // Title
        Expanded(
          child: Center(
            child: Text(
              title,
              style: AppTextStyles.subHeading(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),

        // Action Icon
        if (actionIcon != null)
          IconButton(onPressed: onActionTap ?? () {}, icon: Icon(actionIcon))
        else
          const SizedBox(width: 48), // placeholder for alignment
      ],
    );
  }
}
