import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/bottom_navigation_bar.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';

class TopBar extends StatelessWidget {
  final String title;
  final IconData? actionIcon;
  final bool showBackButton;

  const TopBar({
    super.key,
    required this.title,
    this.actionIcon,
    this.showBackButton = false,
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
              style: AppTextStyles.subHeading.copyWith(
                color: ColorConstants.heading,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),

        // Action Icon
        if (actionIcon != null)
          IconButton(onPressed: () {}, icon: Icon(actionIcon))
        else
          const SizedBox(width: 48), // placeholder for alignment
      ],
    );
  }
}
