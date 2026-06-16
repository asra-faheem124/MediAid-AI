import 'package:flutter/material.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/text_styles.dart';

// =========================================================
// ================= CUSTOM TEXT FIELD =====================
// =========================================================

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggle;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? errorText;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.obscureText = false,
    this.onToggle,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword ? obscureText : false,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.lightBody(context),
        errorText: errorText,
        prefixIcon: Icon(icon, color: ColorConstants.primary),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: onToggle,
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Theme.of(context).hintColor,
                ),
              )
            : null,
        filled: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide:  BorderSide(color: Theme.of(context).dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: ColorConstants.primary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}

// =========================================================
// ================= SEARCH TEXT FIELD =====================
// =========================================================

class SearchTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;

  const SearchTextField({super.key, required this.hintText, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.lightBody(context),

        prefixIcon: Icon(
  Icons.search,
  color: Theme.of(context).hintColor,
) ,

        filled: true,
        fillColor:Theme.of(context).inputDecorationTheme.fillColor,

        contentPadding: const EdgeInsets.symmetric(vertical: 18),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),

          borderSide:  BorderSide(color: Theme.of(context).dividerColor),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),

          borderSide: const BorderSide(
            color: ColorConstants.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
