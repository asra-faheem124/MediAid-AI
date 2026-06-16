import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/SnackBar.dart';
import 'package:mediaid_ui/components/buttons.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/form_components.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/controller/AuthController.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Authcontroller authController = Get.put(Authcontroller());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 450,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock_reset,
                          size: 80,
                          color: ColorConstants.primaryDark,
                        ),

                        const SizedBox(height: 24),

                        Text(
                          "Forgot Password",
                          style: AppTextStyles.heading(context),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 12),

                        Text(
                          "Enter your email address and we'll send you a link to reset your password.",
                          style: AppTextStyles.subHeading(context),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 32),

                        CustomTextField(
                          controller: emailController,
                          hintText: "Enter your email",
                          icon: Icons.email_outlined,
                        ),

                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          child: PrimaryButton(
                            text: "Send Reset Link",
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await authController.forgetPassword(
                                  emailController.text.trim(),
                                );
                              } else {
                                AppSnackbar.error(
                                  context,
                                  "Please enter a valid email",
                                );
                              }
                            },
                          ),
                        ),

                        const SizedBox(height: 16),
SecondaryButtons(text: 'Back to Login',   onPressed: () {
                            Get.back();
                          },)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}