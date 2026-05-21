import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/buttons.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/form_components.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/auth/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 30),

              // ================= APP LOGO =================

              Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset("assets/images/Mediaid AI Logo.png"),
                ),
              ),

              const SizedBox(height: 28),

              // ================= TITLE =================

              Center(
                child: Text(
                  "Welcome Back",
                  style: AppTextStyles.heading,
                ),
              ),

              const SizedBox(height: 10),

              Center(
                child: Text(
                  "Login to continue using MediAid AI",
                  style: AppTextStyles.lightBody,
                ),
              ),

              const SizedBox(height: 40),

              // ================= EMAIL =================

              Text(
                "Email",
                style: AppTextStyles.subHeading.copyWith(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 10),

              const CustomTextField(
                hintText: "Enter your email",
                icon: Icons.email_outlined,
              ),

              const SizedBox(height: 22),

              // ================= PASSWORD =================

              Text(
                "Password",
                style: AppTextStyles.subHeading.copyWith(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 10),

              const CustomTextField(
                hintText: "Enter your password",
                icon: Icons.lock_outline_rounded,
                isPassword: true,
              ),

              const SizedBox(height: 14),

              // ================= FORGOT PASSWORD =================

              Align(
                alignment: Alignment.centerRight,

                child: Text(
                  "Forgot Password?",
                  style: AppTextStyles.primaryText.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 34),

              // ================= LOGIN BUTTON =================

              PrimaryButton(
                text: "Login",
                onPressed: () {},
              ),

              const SizedBox(height: 30),

              // ================= DIVIDER =================

              Row(
                children: [
                  const Expanded(child: Divider()),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),

                    child: Text(
                      "OR",
                      style: AppTextStyles.lightBody,
                    ),
                  ),

                  const Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 30),

              // ================= GOOGLE BUTTON =================

              SocialLoginButton(
                text: "Continue with Google",
                icon: Icons.g_mobiledata_rounded,
                onPressed: () {},
              ),

              const SizedBox(height: 40),

              // ================= SIGNUP TEXT =================

              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text(
                    "Don't have an account? ",
                    style: AppTextStyles.body,
                  ),

                  GestureDetector(
                    onTap: () {
                      Get.to(const SignupScreen());
                    },

                    child: Text(
                      "Sign Up",
                      style: AppTextStyles.primaryText,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

