import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/SnackBar.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    super.onClose();
  }

  Future<void> fetchUserData() async {
    final uid = auth.currentUser?.uid;

    if (uid == null) {
      AppSnackbar.error(Get.context!, 'User not authenticated');
      return;
    }

    try {
      final userDoc = await firestore.collection('User').doc(uid).get();

      if (userDoc.exists && userDoc.data() != null) {
        final data = userDoc.data() as Map<String, dynamic>;

        // ✅ Correctly setting text on controllers
        nameController.text = data['name'] ?? '';
        emailController.text = data['email'] ?? '';
      } else {
        AppSnackbar.success(Get.context!, 'User data could not be found.');
      }
    } catch (e) {
      AppSnackbar.error(Get.context!, e.toString());
    }
  }

  Future<void> updateUser() async {
    try {
      EasyLoading.show(status: 'Please wait');
      final uid = auth.currentUser!.uid;
      await firestore.collection('User').doc(uid).update({
        'name': nameController.text.trim(),
      });
       EasyLoading.dismiss();
      AppSnackbar.success(Get.context!, 'Update Successfully');
    } catch (e) {
      print('error $e');
      AppSnackbar.error(Get.context!, '$e');
    }
  }
}
