// ============================================================
// ScanController.dart
// GetX controller — owns image picking, inference, navigation
// ============================================================

import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediaid_ui/model/resultModel.dart';
import 'package:mediaid_ui/services/InjuryService.dart';

import '../pages/firstAid/processing_screen.dart';
import '../pages/firstAid/result_screen.dart';

class ScanController extends GetxController {
  final ImagePicker   _picker     = ImagePicker();
  final Injuryservice _classifier = Injuryservice();

  // ── Observable state ──────────────────────────────────────────
  final Rx<File?>        selectedImage = Rx<File?>(null);
  final Rx<ResultModel?> result        = Rx<ResultModel?>(null);
  final RxBool           isAnalyzing   = false.obs;

  // ── Lifecycle ─────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    _classifier.initialize();   // Load TFLite model when controller starts
  }

  @override
  void onClose() {
    _classifier.dispose();
    super.onClose();
  }

  // ── Image picking ─────────────────────────────────────────────
  Future<void> pickFromCamera() async {
    try {
      final XFile? file = await _picker.pickImage(
        source:       ImageSource.camera,
        imageQuality: 90,
      );
      if (file != null) selectedImage.value = File(file.path);
    } catch (e) {
      _showError('Camera Error', 'Could not access camera. Check permissions.');
    }
  }

  Future<void> pickFromGallery() async {
    try {
      final XFile? file = await _picker.pickImage(
        source:       ImageSource.gallery,
        imageQuality: 90,
      );
      if (file != null) selectedImage.value = File(file.path);
    } catch (e) {
      _showError('Gallery Error', 'Could not open gallery. Check permissions.');
    }
  }

  // ── Core: analyze image ───────────────────────────────────────
  // Flow:
  //   1. Navigate to ProcessingScreen immediately (shows animation)
  //   2. Run TFLite inference in background, AND wait at least 1.5s
  //      so ProcessingScreen is actually visible to the user
  //      (inference alone often finishes in <300ms, which made the
  //       screen appear to "skip" straight to Result before).
  //   3a. Success → store result → replace ProcessingScreen with ResultScreen
  //   3b. Failure → go back to ScanScreen + show error snackbar
  Future<void> analyzeImage() async {
    if (selectedImage.value == null) return;

    isAnalyzing.value = true;

    // Show processing animation right away
    Get.to(() => const ProcessingScreen());

    try {
      // Minimum time ProcessingScreen stays visible, regardless of
      // how fast inference actually finishes.
      final minDisplay = Future.delayed(const Duration(milliseconds: 1500));
      final inferenceFuture = _classifier.classify(selectedImage.value!);

      // Wait for both — whichever finishes last determines total wait time
      final outcomes = await Future.wait([inferenceFuture, minDisplay]);
      final prediction = outcomes[0];

      isAnalyzing.value = false;

      if (prediction != null) {
        result.value = prediction as dynamic;
        Get.off(() => const ResultScreen());
      } else {
        Get.back();
        _showError(
          'Analysis Failed',
          'Could not analyze the image. Please retake with better lighting.',
        );
      }
    } catch (e) {
      // Catches any uncaught exception from classify() (e.g. shape
      // mismatch if labels.txt/model class count don't match)
      isAnalyzing.value = false;
      Get.back();
      _showError('Analysis Error', 'Something went wrong: $e');
    }
  }

  // ── Reset for retake ──────────────────────────────────────────
  void reset() {
    selectedImage.value = null;
    result.value        = null;
  }

  // ── Private helpers ───────────────────────────────────────────
  void _showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration:      const Duration(seconds: 3),
    );
  }
}