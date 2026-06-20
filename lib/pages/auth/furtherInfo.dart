// ============================================================
// furtherInfo.dart
// One-time, full-screen, blocking onboarding step shown after
// signup/login — collects GPS location + 2 emergency contacts.
// Cannot be dismissed until both are provided and saved.
// ============================================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaid_ui/components/buttons.dart';
import 'package:mediaid_ui/components/constants.dart';
import 'package:mediaid_ui/components/form_components.dart';
import 'package:mediaid_ui/components/text_styles.dart';
import 'package:mediaid_ui/components/bottom_navigation_bar.dart';
import 'package:mediaid_ui/controller/AuthController.dart';

class Furtherinfo extends StatefulWidget {
  const Furtherinfo({super.key});

  @override
  State<Furtherinfo> createState() => _FurtherinfoState();
}

class _FurtherinfoState extends State<Furtherinfo> {
  final _formKey = GlobalKey<FormState>();
  final Authcontroller _controller = Get.find<Authcontroller>();

  final contact1Name  = TextEditingController();
  final contact1Phone = TextEditingController();
  final contact2Name  = TextEditingController();
  final contact2Phone = TextEditingController();

  @override
  void dispose() {
    contact1Name.dispose();
    contact1Phone.dispose();
    contact2Name.dispose();
    contact2Phone.dispose();
    super.dispose();
  }

  Future<void> _onContinue() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_controller.hasLocation) {
      Get.snackbar(
        'Location Required',
        'Please tap "Detect My Location" before continuing.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final success = await _controller.saveOnboardingDetails(
      contact1Name:  contact1Name.text,
      contact1Phone: contact1Phone.text,
      contact2Name:  contact2Name.text,
      contact2Phone: contact2Phone.text,
    );

    if (success) {
      // Replace this screen entirely — user can't come back to it
      Get.offAll(() => BottomNavBar());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // No back button on purpose — this step is mandatory
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= ICON =================
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: ColorConstants.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shield_outlined,
                      color: ColorConstants.primary,
                      size: 44,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ================= TITLE =================
                Center(
                  child: Text(
                    "One Last Step",
                    style: AppTextStyles.heading(context),
                  ),
                ),

                const SizedBox(height: 8),

                Center(
                  child: Text(
                    "This helps us provide faster help in emergencies.",
                    style: AppTextStyles.lightBody(context),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 36),

                // ================= LOCATION SECTION =================
                Text(
                  "Your Location",
                  style: AppTextStyles.subHeading(context).copyWith(fontSize: 16),
                ),

                const SizedBox(height: 10),

                Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton.icon(
                        onPressed: _controller.isFetchingLocation.value
                            ? null
                            : _controller.fetchLocation,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: _controller.hasLocation
                                ? ColorConstants.success
                                : ColorConstants.primary,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        icon: _controller.isFetchingLocation.value
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Icon(
                                _controller.hasLocation
                                    ? Icons.check_circle_rounded
                                    : Icons.my_location_rounded,
                                color: _controller.hasLocation
                                    ? ColorConstants.success
                                    : ColorConstants.primary,
                              ),
                        label: Text(
                          _controller.hasLocation
                              ? "Location Captured"
                              : "Detect My Location",
                          style: AppTextStyles.primaryText.copyWith(
                            color: _controller.hasLocation
                                ? ColorConstants.success
                                : ColorConstants.primary,
                          ),
                        ),
                      ),
                    ),
                    if (_controller.locationStatus.value.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          _controller.locationStatus.value,
                          style: AppTextStyles.caption(context),
                        ),
                      ),
                  ],
                )),

                const SizedBox(height: 32),

                // ================= EMERGENCY CONTACT 1 =================
                Text(
                  "Emergency Contact 1",
                  style: AppTextStyles.subHeading(context).copyWith(fontSize: 16),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: contact1Name,
                  hintText: "Full name",
                  icon: Icons.person_outline_rounded,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Name cannot be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: contact1Phone,
                  hintText: "Phone number",
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Phone number cannot be empty";
                    }
                    if (value.trim().length < 7) {
                      return "Enter a valid phone number";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // ================= EMERGENCY CONTACT 2 =================
                Text(
                  "Emergency Contact 2",
                  style: AppTextStyles.subHeading(context).copyWith(fontSize: 16),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: contact2Name,
                  hintText: "Full name",
                  icon: Icons.person_outline_rounded,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Name cannot be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: contact2Phone,
                  hintText: "Phone number",
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Phone number cannot be empty";
                    }
                    if (value.trim().length < 7) {
                      return "Enter a valid phone number";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 36),

                // ================= CONTINUE BUTTON =================
                Obx(() => PrimaryButton(
                  text: _controller.isSavingOnboarding.value ? "Saving..." : "Continue",
                  onPressed: _controller.isSavingOnboarding.value ? () {} : _onContinue,
                )),

                const SizedBox(height: 12),

                Center(
                  child: Text(
                    "This information is only used to help you in emergencies.",
                    style: AppTextStyles.caption(context),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}