import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/buttons.dart';
import 'package:mediaid_ui/components/form_components.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/controller/AuthController.dart';
import 'package:mediaid_ui/pages/auth/forgotPassword.dart';
import 'package:mediaid_ui/pages/auth/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final Authcontroller _authcontroller = Get.put(Authcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

          child: Form(
            key: _formkey,
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
                  child: Text("Welcome Back", style: AppTextStyles.heading(context)),
                ),

                const SizedBox(height: 10),

                Center(
                  child: Text(
                    "Login to continue using MediAid AI",
                    style: AppTextStyles.lightBody(context),
                  ),
                ),

                const SizedBox(height: 40),

                // ================= EMAIL =================
                Text(
                  "Email",
                  style: AppTextStyles.subHeading(context).copyWith(fontSize: 16),
                ),

                const SizedBox(height: 10),

                CustomTextField(
                  controller: email,
                  hintText: "Enter your email",
                  icon: Icons.email_outlined,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email cannot be empty";
                    }
                    if (!GetUtils.isEmail(value.trim())) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 22),

                // ================= PASSWORD =================
                Text(
                  "Password",
                  style: AppTextStyles.subHeading(context).copyWith(fontSize: 16),
                ),

                const SizedBox(height: 10),
                Obx(
                  () => CustomTextField(
                    controller: password,
                    hintText: "Create password",
                    icon: Icons.lock_outline_rounded,
                    isPassword: true,

                    obscureText: !_authcontroller.isVisible.value,

                    onToggle: () {
                      _authcontroller.isVisible.toggle();
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Password cannot be empty";
                      }
                      if (value.trim().length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 14),

                // ================= FORGOT PASSWORD =================
                Align(
                  alignment: Alignment.centerRight,

                  child: InkWell(
                    onTap: () => Get.to(ForgetPassword()),
                    child: Text(
                      "Forgot Password?",
                      style: AppTextStyles.primaryText.copyWith(fontSize: 14),
                    ),
                  ),
                ),

                const SizedBox(height: 34),

                // ================= LOGIN BUTTON =================
                PrimaryButton(
                  text: "Login",
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _authcontroller.login(
                        formkey: _formkey,
                        email: email,
                        password: password,
                      );
                    }
                  },
                ),

                const SizedBox(height: 30),

                // ================= DIVIDER =================
                Row(
                  children: [
                    const Expanded(child: Divider()),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),

                      child: Text("OR", style: AppTextStyles.lightBody(context)),
                    ),

                    const Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 30),

                // ================= GOOGLE BUTTON =================
                SocialLoginButton(
                  text: "Continue with Google",
                  icon: Icons.g_mobiledata_rounded,
                  onPressed: () => _authcontroller.loginWithGoogle(),
                ),

                const SizedBox(height: 40),

                // ================= SIGNUP TEXT =================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text("Don't have an account? ", style: AppTextStyles.body(context)),

                    GestureDetector(
                      onTap: () {
                        Get.to(SignupScreen());
                      },

                      child: Text("Sign Up", style: AppTextStyles.primaryText),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
