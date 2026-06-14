import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendlock/feature/profile/domain/repository/profile_repository.dart';

class ChangePasswordController extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isSaving = false;

  // repository
  final ProfileRepository profileRepository = ProfileRepository.instance;

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> updatePassword() async {
    final current = currentPasswordController.text;
    final newPass = newPasswordController.text;
    final confirm = confirmPasswordController.text;

    if (current.isEmpty || newPass.isEmpty || confirm.isEmpty) {
      Get.snackbar(
        'Missing fields',
        'Please fill in all password fields.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (newPass.length < 6) {
      Get.snackbar(
        'Weak password',
        'New password must be at least 6 characters.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (newPass != confirm) {
      Get.snackbar(
        'Password mismatch',
        'New password and confirm password do not match.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isSaving = true;
    update();

    final response = await profileRepository.changePassword(
      oldPassword: current,
      newPassword: newPass,
      confirmPassword: confirm,
    );
    if (response) {
      Get.back();
      Get.snackbar(
        'Password updated',
        'Your password has been changed successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        'Password update failed',
        'Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
