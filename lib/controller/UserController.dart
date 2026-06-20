import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/SnackBar.dart';
import 'package:mediaid_ui/model/UserModel.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emegergencycontactNumber1 =
      TextEditingController();
  final TextEditingController emergencyName1 = TextEditingController();
  final TextEditingController emergencyName2 = TextEditingController();
  final TextEditingController emergencyContactNumber2 = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    emegergencycontactNumber1.dispose();
    emergencyContactNumber2.dispose();
    emergencyName1.dispose();
    emergencyName2.dispose();
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

        // 👇 Parse the whole document through Usermodel — this correctly
        //    handles the nested 'location' map and 'emergencyContacts' list,
        //    instead of reading them as flat top-level strings.
        final user = Usermodel.fromMap(data);

        // ── Basic fields ──────────────────────────────────────────
        nameController.text = user.name;
        emailController.text = user.email;

        // ── Address (from the nested location map) ────────────────
        // user.location.address is the human-readable string built
        // by reverse-geocoding in AuthController.fetchLocation().
        addressController.text = user.location?.address ?? '';

        // ── Emergency contacts (from the list) ─────────────────────
        // emergencyContacts[0] = Contact 1, emergencyContacts[1] = Contact 2
        if (user.emergencyContacts != null) {
          if (user.emergencyContacts!.isNotEmpty) {
            emegergencycontactNumber1.text = user.emergencyContacts![0].phone;
            // If you also have separate name fields for each contact,
            // e.g. emegergencycontactNumber1Name / emergencyContactNumber2Name controllers, set them too:
            emergencyName1.text = user.emergencyContacts![0].name;
          }
          if (user.emergencyContacts!.length > 1) {
            emergencyContactNumber2.text = user.emergencyContacts![1].phone;
            emergencyName2.text = user.emergencyContacts![0].name;
          }
        }
      } else {
        AppSnackbar.error(Get.context!, 'User data could not be found.');
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

        'emergencyContacts': [
          {
            'name': emergencyName1.text.trim(),
            'phone': emegergencycontactNumber1.text.trim(),
          },
          {
            'name': emergencyName2.text.trim(),
            'phone': emergencyContactNumber2.text.trim(),
          },
        ],
      });

      EasyLoading.dismiss();

      AppSnackbar.success(Get.context!, 'Updated Successfully');
    } catch (e) {
      EasyLoading.dismiss();
      print('error $e');

      AppSnackbar.error(Get.context!, e.toString());
    }
  }
}
