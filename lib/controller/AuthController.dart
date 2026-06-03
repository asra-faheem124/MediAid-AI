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
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final Authservice _authservice = Get.put(Authservice());

  Future<void> signUp({
    required GlobalKey<FormState> formkey,
    required name,
    required email,
    required password,
  }) async {
    if (!formkey.currentState!.validate()) {
      AppSnackbar.error(Get.context!, 'Invalid credentials');
    } else {
      String username = name.text.trim();
      String useremail = email.text.trim();
      String userpassword = password.text.trim();

      try {
        EasyLoading.show(status: "Registering...");
        UserCredential? userCredential = await _authservice.SignUpMethod(
          username,
          useremail,
          userpassword,
        );
        EasyLoading.dismiss();
        if (userCredential != null) {
          AppSnackbar.success(
            Get.context!,
            'Register Successfully! Please verify your email to login',
          );
          Get.to(LoginScreen());
        } else {
          AppSnackbar.error(
            Get.context!,
            'Something went wrong please try again',
          );
        }
      } catch (e) {
        EasyLoading.dismiss();
        print('Error $e');
        // AppSnackbar.error(Get.context!, '$e');
      }
    }
  }

  Future<void> login({
    required GlobalKey<FormState> formkey,
    required email,
    required password,
  }) async {
  

    String userEmail = email.text.trim();
    String userPassword = password.text.trim();
    UserCredential? userCredential = await _authservice.LogInMethod(
      email: userEmail,
      password: userPassword,
    );

    if (userCredential == null) return;
    if (!userCredential.user!.emailVerified) {
      AppSnackbar.error(Get.context!, 'Please Verify Your Email');

      return;
    }
    AppSnackbar.success(Get.context!, 'Login Successful');
    Get.offAll(BottomNavBar());
  }

  Future<void> forgetPassword(String useremail) async {
    try {
      EasyLoading.show(status: 'Please wait');
      await _firebaseAuth.sendPasswordResetEmail(email: useremail);
      update();
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
