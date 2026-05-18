import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/utils/app_snackbar.dart';

class ResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isLoading = false.obs;

  Future<void> save() async {
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      AppSnackBar.error('Please fill all fields');
      return;
    }
    if (newPassword.length < 6) {
      AppSnackBar.error('Password must be at least 6 characters');
      return;
    }
    if (newPassword != confirmPassword) {
      AppSnackBar.error('Passwords do not match');
      return;
    }

    isLoading.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 500));
    isLoading.value = false;
    AppSnackBar.success('Password reset successfully');
    Get.offAllNamed(AppRoutes.instance.loginScreen);
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
