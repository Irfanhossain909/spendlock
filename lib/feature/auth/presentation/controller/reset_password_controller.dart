import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/utils/app_snackbar.dart';
import 'package:spendlock/feature/auth/domain/repository/auth_repository.dart';

class ResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isLoading = false.obs;

  final AuthRepository authRepository = AuthRepository.instance;

  String get otp {
    final args = Get.arguments;
    if (args is Map) {
      return args['otp']?.toString().trim() ?? '';
    }
    return '';
  }

  Future<void> save() async {
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (otp.isEmpty) {
      AppSnackBar.error('OTP not found. Please verify again.');
      return;
    }
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
    try {
      final response = await authRepository.resetPassword(
        otp: otp,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      if (response) {
        AppSnackBar.success('Password reset successfully');
        Get.offAllNamed(AppRoutes.instance.loginScreen);
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
