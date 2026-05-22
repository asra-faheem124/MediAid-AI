import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediaid_ui/components/SnackBar.dart';
import 'package:mediaid_ui/model/UserModel.dart';

class Authservice extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  var isVisible = false.obs;

  Future<UserCredential?> SignUpMethod(
    String name,
    String email,

    String password,
  ) async {
    try {
      EasyLoading.show(status: 'Please wait');
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.sendEmailVerification();

      Usermodel usermodel = Usermodel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        password: password,
      );

      await _firebaseFireStore
          .collection('User')
          .doc(userCredential.user!.uid)
          .set(usermodel.toMap());
      EasyLoading.dismiss();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      AppSnackbar.error(Get.context!, e.message ?? 'Some Error occured');
    }
    return null;
  }

  Future<UserCredential?> LogInMethod({
    required String email,
    required String password,
  }) async {
    try {
      EasyLoading.show(status: 'Please Wait');
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      EasyLoading.dismiss();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();

      AppSnackbar.error(Get.context!, e.message ?? 'Some Error occured');
    }
    return null;
  }

  // Future<UserCredential?> signUpWithGoogle() async {
  //   try {
  //     if (kIsWeb) {
  //       // Web sign-in
  //       GoogleAuthProvider authProvider = GoogleAuthProvider();
  //       return await _auth.signInWithPopup(authProvider);
  //     } else {
  //       // Android/iOS sign-in
  //       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //       if (googleUser == null) return null; // Cancelled

  //       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  //       final credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );

  //       return await _auth.signInWithCredential(credential);
  //     }
  //   } catch (e) {
  //     print('Google sign-in error: $e');
  //     return null;
  //   }
  // }
}
