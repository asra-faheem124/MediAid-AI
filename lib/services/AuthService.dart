import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mediaid_ui/components/SnackBar.dart';
import 'package:mediaid_ui/model/UserModel.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authservice extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  var isVisible = false.obs;

  // ─── Helper: Check internet ──────────────────────────────
  Future<bool> _isOnline() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  // ─── Helper: Save session locally ───────────────────────
  Future<void> _saveSession({
    required bool isLoggedIn,
    required bool isGuest,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
    await prefs.setBool('isGuest', isGuest);
  }

  // ─── Helper: Clear session ───────────────────────────────
  Future<void> _clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.setBool('isGuest', false);
  }

  // ─── Sign Up ─────────────────────────────────────────────
  Future<UserCredential?> SignUpMethod(
    String name,
    String email,
    String password,
  ) async {
    // Block if offline
    if (!await _isOnline()) {
      AppSnackbar.error(
        Get.context!,
        'No internet connection. Please connect and try again.',
      );
      return null;
    }

    try {
      EasyLoading.show(status: 'Please wait');

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user!.sendEmailVerification();

      Usermodel usermodel = Usermodel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
      );

      await _firebaseFireStore
          .collection('User')
          .doc(userCredential.user!.uid)
          .set(usermodel.toMap());

      // ✅ Save session locally for offline use later
      await _saveSession(isLoggedIn: true, isGuest: false);

      EasyLoading.dismiss();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      AppSnackbar.error(Get.context!, e.message ?? 'Some error occurred');
    }
    return null;
  }

  // ─── Login ───────────────────────────────────────────────
  Future<UserCredential?> LogInMethod({
    required String email,
    required String password,
  }) async {
    // Block if offline
    if (!await _isOnline()) {
      AppSnackbar.error(
        Get.context!,
        'No internet connection. Please connect and try again.',
      );
      return null;
    }

    try {
      EasyLoading.show(status: 'Please Wait');

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // ✅ Save session locally for offline use later
      await _saveSession(isLoggedIn: true, isGuest: false);

      EasyLoading.dismiss();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      AppSnackbar.error(Get.context!, e.message ?? 'Some error occurred');
    }
    return null;
  }

  // ─── Google Sign In ──────────────────────────────────────
Future<UserCredential?> signInWithGoogle() async {
  // Block if offline
  if (!await _isOnline()) {
    AppSnackbar.error(
      Get.context!,
      'No internet connection. Please connect and try again.',
    );
    return null;
  }

  try {
    EasyLoading.show(status: 'Please Wait');

    final GoogleSignInAccount? googleUser = await GoogleSignIn(
  clientId: '686808185076-k6on85pc8u73urm0ne2cqaun4gmd9k4c.apps.googleusercontent.com', // for web
).signIn();

    if (googleUser == null) {
      EasyLoading.dismiss();
      return null; // User cancelled
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    // Save user to Firestore if first time signing in
    final userDoc = await _firebaseFireStore
        .collection('User')
        .doc(userCredential.user!.uid)
        .get();

    if (!userDoc.exists) {
      Usermodel usermodel = Usermodel(
        id: userCredential.user!.uid,
        name: userCredential.user!.displayName ?? 'User',
        email: userCredential.user!.email ?? '',
      );

      await _firebaseFireStore
          .collection('User')
          .doc(userCredential.user!.uid)
          .set(usermodel.toMap());
    }

    // ✅ Save session locally for offline use later
    await _saveSession(isLoggedIn: true, isGuest: false);

    EasyLoading.dismiss();
    return userCredential;
  } on FirebaseAuthException catch (e) {
    EasyLoading.dismiss();
    AppSnackbar.error(Get.context!, e.message ?? 'Some error occurred');
  } catch (e, s) {
  EasyLoading.dismiss();
  print("========================");
  print(e);
  print(s);
  print("========================");

  AppSnackbar.error(
    Get.context!,
    "Google Sign-In Failed\n$e",
  );
}
  return null;
}

  // ─── Guest Mode ──────────────────────────────────────────
  // ✅ NEW — No internet needed at all
  Future<void> continueAsGuest() async {
    await _saveSession(isLoggedIn: false, isGuest: true);
    // Caller handles navigation
  }

  // ─── Logout ──────────────────────────────────────────────
  Future<void> LogOut() async {
    await _auth.signOut();
    await _clearSession();
    // Caller handles navigation back to onboarding
  }

  // ─── Get current user (safe getter) ─────────────────────
  User? get currentUser => _auth.currentUser;
}