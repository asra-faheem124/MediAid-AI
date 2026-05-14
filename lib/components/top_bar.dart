import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/bottom_navigation_bar.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';

class TopBar extends StatelessWidget {
  final String title;
  final IconData actionIcon;

  const TopBar({super.key, required this.title, required this.actionIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        IconButton(
          onPressed: () {
            Get.offAll(BottomNavBar());
          },

          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),

        Text(
          title,
          style: AppTextStyles.subHeading.copyWith(
            color: ColorConstants.heading,
          ),
        ),

        IconButton(onPressed: () {}, icon: Icon(actionIcon)),
      ],
    );
  }
}
