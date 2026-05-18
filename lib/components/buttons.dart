import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';

// =========== PRIMARY BUTTON ===========
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;  
  final IconData actionIcon;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.actionIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,

      child: ElevatedButton(
        onPressed: onPressed,

        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(text, style: AppTextStyles.button),

            const SizedBox(width: 10),

            Icon(actionIcon, color: Colors.white,),
          ],
        ),
      ),
    );
  }
}

// ================== SECONDARY BUTTON ==================
class SecondaryButtons extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SecondaryButtons({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,

      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(56),

        side: const BorderSide(
          color: ColorConstants.primary,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),

      child: Text(
        text,
        style: AppTextStyles.primaryText,
      ),
    );
  }
}

// ================== DANGER BUTTON ==================

class DangerButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const DangerButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,

      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.danger,
        elevation: 0,
        minimumSize: const Size.fromHeight(56),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),

      child: Text(
        text,
        style: AppTextStyles.button,
      ),
    );
  }
}
