import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/buttons.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/form_components.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/auth/login_screen.dart';
import 'package:mediaid_ui/controller/AuthController.dart';

class SignupScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final Authcontroller _authcontroller = Get.put(Authcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const SizedBox(height: 20),

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
                  child: Text("Create Account", style: AppTextStyles.heading),
                ),

                const SizedBox(height: 10),

                Center(
                  child: Text(
                    "Create your MediAid AI account",
                    style: AppTextStyles.lightBody,
                  ),
                ),

                const SizedBox(height: 40),

                // ================= FULL NAME =================
                Text(
                  "Full Name",
                  style: AppTextStyles.subHeading.copyWith(fontSize: 16),
                ),

                const SizedBox(height: 10),

                CustomTextField(
                  controller: name,
                  hintText: "Enter your full name",
                  icon: Icons.person_outline_rounded,
                ),

                const SizedBox(height: 22),

                // ================= EMAIL =================
                Text(
                  "Email",
                  style: AppTextStyles.subHeading.copyWith(fontSize: 16),
                ),

                const SizedBox(height: 10),

                CustomTextField(
                  controller: email,
                  hintText: "Enter your email",
                  icon: Icons.email_outlined,
                ),

                const SizedBox(height: 22),

                // ================= PASSWORD =================
                Text(
                  "Password",
                  style: AppTextStyles.subHeading.copyWith(fontSize: 16),
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
                  ),
                ),
                const SizedBox(height: 22),

                // ================= CONFIRM PASSWORD =================
                // Text(
                //   "Confirm Password",
                //   style: AppTextStyles.subHeading.copyWith(fontSize: 16),
                // ),

                // const SizedBox(height: 10),

                // const CustomTextField(
                //   hintText: "Confirm password",
                //   icon: Icons.lock_outline_rounded,
                //   isPassword: true,
                // ),

                // const SizedBox(height: 36),

                // ================= SIGNUP BUTTON =================
                PrimaryButton(
                  text: "Create Account",
                  onPressed: () {
                    _authcontroller.signUp(
                      formkey: _formKey,
                      name: name,
                      email: email,
                      password: password,
                    );
                  },
                ),

                const SizedBox(height: 34),

                // ================= LOGIN TEXT =================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text(
                      "Already have an account? ",
                      style: AppTextStyles.body,
                    ),

                    GestureDetector(
                      onTap: () {
                        Get.to(LoginScreen());
                      },

                      child: Text("Login", style: AppTextStyles.primaryText),
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
