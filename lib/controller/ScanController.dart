import 'dart:io';
import 'package:get/get.dart';
import 'package:mediaid_ui/services/camera_service.dart';
import 'package:mediaid_ui/pages/firstAid/processing_screen.dart';

class ScanController extends GetxController {
  final CameraService _cameraService = CameraService();

  var selectedImage = Rxn<File>();
  var isAnalyzing = false.obs;

  // ── Camera ────────────────────────────────────────────
  Future<void> pickFromCamera() async {
    final File? image = await _cameraService.takePhoto();
    if (image != null) {
      selectedImage.value = image;
    }
  }

  // ── Gallery ───────────────────────────────────────────
  Future<void> pickFromGallery() async {
    final File? image = await _cameraService.pickFromGallery();
    if (image != null) {
      selectedImage.value = image;
    }
  }

  // ── Analyze → goes to processing screen ──────────────
  void analyzeImage() {
    if (selectedImage.value == null) return;
    Get.to(() => ProcessingScreen());
  }

  // ── Reset ─────────────────────────────────────────────
  void reset() {
    selectedImage.value = null;
    isAnalyzing.value = false;
  }
}