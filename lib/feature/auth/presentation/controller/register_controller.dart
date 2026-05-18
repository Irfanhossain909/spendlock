import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/utils/app_snackbar.dart';
import 'package:spendlock/feature/auth/presentation/controller/verify_email_controller.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  Future<void> register() async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      AppSnackBar.error('Please fill all fields');
      return;
    }
    isLoading.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 600));
    isLoading.value = false;
    if (Get.isRegistered<VerifyEmailController>()) {
      Get.delete<VerifyEmailController>(force: true);
    }
    Get.toNamed(AppRoutes.instance.verifyEmailScreen);
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
