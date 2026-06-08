import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/SnackBar.dart';
import 'package:mediaid_ui/components/bottom_navigation_bar.dart';
import 'package:mediaid_ui/pages/auth/login_screen.dart';
import 'package:mediaid_ui/services/AuthService.dart';

class Authcontroller extends GetxController {
  var isVisible = false.obs;
  var isConfirmVisible = false.obs; // ✅ for confirm password field
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Authservice _authservice = Get.find<Authservice>(); // ✅ find not put

  // ─── Sign Up ─────────────────────────────────────────
  Future<void> signUp({
    required GlobalKey<FormState> formkey,
    required name,
    required email,
    required password,
  }) async {
    if (!formkey.currentState!.validate()) return;

    String username = name.text.trim();
    String useremail = email.text.trim();
    String userpassword = password.text.trim();

    try {
      UserCredential? userCredential = await _authservice.SignUpMethod(
        username,
        useremail,
        userpassword,
      );

      if (userCredential != null) {
        AppSnackbar.success(
          Get.context!,
          'Registered! Please verify your email to login.',
        );
        Get.offAll(() => LoginScreen());
      }
    } catch (e) {
      EasyLoading.dismiss();
      AppSnackbar.error(Get.context!, 'Something went wrong. Try again.');
    }
  }

  // ─── Login ───────────────────────────────────────────
  Future<void> login({
    required GlobalKey<FormState> formkey,
    required email,
    required password,
  }) async {
    if (!formkey.currentState!.validate()) return;

    String userEmail = email.text.trim();
    String userPassword = password.text.trim();

    UserCredential? userCredential = await _authservice.LogInMethod(
      email: userEmail,
      password: userPassword,
    );

    if (userCredential == null) return;

    if (!userCredential.user!.emailVerified) {
      AppSnackbar.error(Get.context!, 'Please verify your email first.');
      return;
    }

    AppSnackbar.success(Get.context!, 'Login Successful!');
    Get.offAll(() => BottomNavBar());
  }

  // ─── Google Sign In ──────────────────────────────────
  Future<void> loginWithGoogle() async {
    try {
      UserCredential? userCredential = await _authservice.signInWithGoogle();

      if (userCredential != null) {
        AppSnackbar.success(Get.context!, 'Welcome!');
        Get.offAll(() => BottomNavBar());
      }
    } catch (e) {
      AppSnackbar.error(Get.context!, 'Google sign-in failed. Try again.');
    }
  }

  // ─── Logout ──────────────────────────────────────────
  Future<void> logout() async {
    await _authservice.LogOut(); // clears Firebase + shared prefs
    Get.offAll(() => LoginScreen());
  }

  // ─── Forgot Password ─────────────────────────────────
  Future<void> forgetPassword(String useremail) async {
    try {
      EasyLoading.show(status: 'Please wait');
      await _firebaseAuth.sendPasswordResetEmail(email: useremail);
      EasyLoading.dismiss();
      AppSnackbar.success(
        Get.context!,
        'Password reset link sent to $useremail',
      );
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      AppSnackbar.error(Get.context!, '${e.message}');
    }
  }
}