import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isSaving = false;

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

    await Future<void>.delayed(const Duration(milliseconds: 600));

    isSaving = false;
    update();

    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();

    Get.back();
    Get.snackbar(
      'Password updated',
      'Your password has been changed successfully.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
