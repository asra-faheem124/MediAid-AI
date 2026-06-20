import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/SnackBar.dart';
import 'package:mediaid_ui/components/bottom_navigation_bar.dart';
import 'package:mediaid_ui/model/UserModel.dart';
import 'package:mediaid_ui/pages/auth/furtherInfo.dart';
import 'package:mediaid_ui/pages/auth/login_screen.dart';
import 'package:mediaid_ui/services/AuthService.dart';

class Authcontroller extends GetxController {
  var isVisible = false.obs;
  var isConfirmVisible = false.obs;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Authservice _authservice = Get.find<Authservice>();

  // ============================================================
  // ONBOARDING STATE
  // ============================================================
  final RxBool   isFetchingLocation = false.obs;
  final RxBool   isSavingOnboarding = false.obs;
  final RxString locationStatus     = ''.obs;
  final Rx<double?> latitude        = Rx<double?>(null);
  final Rx<double?> longitude       = Rx<double?>(null);
  final RxString address            = ''.obs;   // ← NEW: human-readable address

  bool get hasLocation => latitude.value != null && longitude.value != null;

  // ─── Detect current GPS location + reverse-geocode to address ──
  Future<void> fetchLocation() async {
    isFetchingLocation.value = true;
    locationStatus.value = 'Checking location permissions...';

    try {
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        locationStatus.value =
            '❌ Location services are off. Please enable GPS and try again.';
        isFetchingLocation.value = false;
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          locationStatus.value = '❌ Location permission denied.';
          isFetchingLocation.value = false;
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        locationStatus.value =
            '❌ Location permission permanently denied. Enable it from app settings.';
        isFetchingLocation.value = false;
        return;
      }

      // 1. Get raw GPS coordinates
      locationStatus.value = 'Fetching your location...';
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      latitude.value  = position.latitude;
      longitude.value = position.longitude;

      // 2. Reverse-geocode coordinates into a readable address
      locationStatus.value = 'Resolving address...';
      try {
        final List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placemarks.isNotEmpty) {
          final p = placemarks.first;
          // Build address from available parts, skipping empty ones
          final parts = [
            p.street,
            p.subLocality,
            p.locality,
            p.administrativeArea,
            p.postalCode,
            p.country,
          ].where((part) => part != null && part.trim().isNotEmpty).toList();

          address.value = parts.join(', ');
          locationStatus.value = '✅ ${address.value}';
        } else {
          // Geocoding returned nothing — fall back to coordinates
          address.value = '';
          locationStatus.value =
              '✅ Location captured (${position.latitude.toStringAsFixed(4)}, '
              '${position.longitude.toStringAsFixed(4)})';
        }
      } catch (geocodeError) {
        // Geocoding failed (e.g. no internet, or no geocoder on device) —
        // we still have valid lat/lng, so don't block the user.
        address.value = '';
        locationStatus.value =
            '✅ Location captured (${position.latitude.toStringAsFixed(4)}, '
            '${position.longitude.toStringAsFixed(4)}) — address lookup failed';
      }
    } catch (e) {
      locationStatus.value = '❌ Could not fetch location: $e';
    } finally {
      isFetchingLocation.value = false;
    }
  }

  // ─── Save onboarding details onto the existing User document ──
  Future<bool> saveOnboardingDetails({
    required String contact1Name,
    required String contact1Phone,
    required String contact2Name,
    required String contact2Phone,
  }) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return false;

    isSavingOnboarding.value = true;
    try {
      final docRef =
          FirebaseFirestore.instance.collection('User').doc(user.uid);

      final snapshot = await docRef.get();
      if (!snapshot.exists) {
        AppSnackbar.error(Get.context!, 'User profile not found. Please log in again.');
        return false;
      }

      final existingUser =
          Usermodel.fromMap(snapshot.data() as Map<String, dynamic>);

      final updatedUser = existingUser.copyWith(
        location: UserLocation(
          latitude: latitude.value!,
          longitude: longitude.value!,
          address: address.value.isNotEmpty ? address.value : null,
        ),
        emergencyContacts: [
          EmergencyContact(
            name: contact1Name.trim(),
            phone: contact1Phone.trim(),
          ),
          EmergencyContact(
            name: contact2Name.trim(),
            phone: contact2Phone.trim(),
          ),
        ],
        onboardingComplete: true,
      );

      await docRef.set(updatedUser.toMap(), SetOptions(merge: true));
      return true;
    } catch (e) {
      AppSnackbar.error(Get.context!, 'Could not save your details: $e');
      return false;
    } finally {
      isSavingOnboarding.value = false;
    }
  }

  // ─── Check if a user has already completed onboarding ───────
  Future<bool> hasCompletedOnboarding(String uid) async {
    try {
      final doc =
          await FirebaseFirestore.instance.collection('User').doc(uid).get();
      if (!doc.exists) return false;
      final data = doc.data();
      return data?['onboardingComplete'] == true;
    } catch (e) {
      return true;
    }
  }

  // ─── Helper: route to Onboarding or Home depending on status ──
  Future<void> _routeAfterAuth(String uid) async {
    final bool completed = await hasCompletedOnboarding(uid);

    if (completed) {
      Get.offAll(() => BottomNavBar());
    } else {
      Get.offAll(() => const Furtherinfo());
    }
  }

  // ============================================================
  // EXISTING AUTH METHODS
  // ============================================================

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
    await _routeAfterAuth(userCredential.user!.uid);
  }

  // ─── Google Sign In ──────────────────────────────────
  Future<void> loginWithGoogle() async {
    try {
      UserCredential? userCredential = await _authservice.signInWithGoogle();

      if (userCredential != null) {
        AppSnackbar.success(Get.context!, 'Welcome!');
        await _routeAfterAuth(userCredential.user!.uid);
      }
    } catch (e) {
      print("Google Sign In Error: $e");
      AppSnackbar.error(Get.context!, "Google Sign-In Failed\n$e");
    }
  }

  // ─── Logout ──────────────────────────────────────────
  Future<void> logout() async {
    await _authservice.LogOut();
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