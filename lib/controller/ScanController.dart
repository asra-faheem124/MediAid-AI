import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediaid_ui/model/resultModel.dart';
import 'package:mediaid_ui/services/InjuryService.dart';
import 'package:mediaid_ui/services/history_service.dart'; 
import '../pages/firstAid/processing_screen.dart';
import '../pages/firstAid/result_screen.dart';

class ScanController extends GetxController {
  final ImagePicker    _picker     = ImagePicker();
  final Injuryservice  _classifier = Injuryservice();
  final HistoryService _history    = HistoryService(); 

  final Rx<File?>        selectedImage = Rx<File?>(null);
  final Rx<ResultModel?> result        = Rx<ResultModel?>(null);
  final RxBool           isAnalyzing   = false.obs;

  @override
  void onInit() {
    super.onInit();
    _classifier.initialize();
  }

  @override
  void onClose() {
    _classifier.dispose();
    super.onClose();
  }

  Future<void> pickFromCamera() async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.camera,
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
        source: ImageSource.gallery,
        imageQuality: 90,
      );
      if (file != null) selectedImage.value = File(file.path);
    } catch (e) {
      _showError('Gallery Error', 'Could not open gallery. Check permissions.');
    }
  }

  Future<void> analyzeImage() async {
    if (selectedImage.value == null) return;

    isAnalyzing.value = true;
    Get.to(() => const ProcessingScreen());

    try {
      final minDisplay     = Future.delayed(const Duration(milliseconds: 1500));
      final inferenceFuture = _classifier.classify(selectedImage.value!);
      final outcomes       = await Future.wait([inferenceFuture, minDisplay]);
      final prediction     = outcomes[0];

      isAnalyzing.value = false;

      if (prediction != null) {
        result.value = prediction as ResultModel;

        //  Save to Firestore history (only if logged in)
        await _history.saveScan(result.value!);

        Get.off(() => const ResultScreen());
      } else {
        Get.back();
        _showError(
          'Analysis Failed',
          'Could not analyze the image. Please retake with better lighting.',
        );
      }
    } catch (e) {
      isAnalyzing.value = false;
      Get.back();
      _showError('Analysis Error', 'Something went wrong: $e');
    }
  }

  void reset() {
    selectedImage.value = null;
    result.value        = null;
  }

  void _showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }
}