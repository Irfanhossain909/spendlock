import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/utils/app_snackbar.dart';
import 'package:spendlock/feature/auth/domain/repository/auth_repository.dart';
import 'package:spendlock/feature/auth/presentation/controller/verify_email_controller.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  // repository
  final AuthRepository authRepository = AuthRepository.instance;

  Future<void> register() async {
    try {
      isLoading.value = true;
      if (nameController.text.trim().isEmpty ||
          emailController.text.trim().isEmpty ||
          passwordController.text.isEmpty) {
        AppSnackBar.error('Please fill all fields');
        return;
      }
      final response = await authRepository.signUp(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        confirmPassword: passwordController.text,
      );
      if (response) {
        if (Get.isRegistered<VerifyEmailController>()) {
          Get.delete<VerifyEmailController>(force: true);
        }
        Get.toNamed(
          AppRoutes.instance.verifyEmailScreen,
          arguments: {'email': emailController.text.trim()},
        );
      } else {
        AppSnackBar.error('Registration failed');
      }
    } catch (e) {
      AppSnackBar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
    // isLoading.value = true;
    // await Future<void>.delayed(const Duration(milliseconds: 600));
    // isLoading.value = false;
    // if (Get.isRegistered<VerifyEmailController>()) {
    //   Get.delete<VerifyEmailController>(force: true);
    // }
    // Get.toNamed(AppRoutes.instance.verifyEmailScreen);
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
