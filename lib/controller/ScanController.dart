import 'dart:io';
import 'package:get/get.dart';
import 'package:mediaid_ui/services/camera_service.dart';

class ScanController extends GetxController {
  final CameraService _cameraService = CameraService();

  var selectedImage = Rxn<File>();

  // ── Camera ────────────────────────────────────────────
  Future<void> pickFromCamera() async {
    final File? image = await _cameraService.takePhoto();
    if (image != null) {
      selectedImage.value = image;
      // analyzeImage() will go here later when model is ready
    }
  }

  // ── Gallery ───────────────────────────────────────────
  Future<void> pickFromGallery() async {
    final File? image = await _cameraService.pickFromGallery();
    if (image != null) {
      selectedImage.value = image;
      // analyzeImage() will go here later when model is ready
    }
  }

  // ── Reset ─────────────────────────────────────────────
  void reset() {
    selectedImage.value = null;
  }
}