import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/service/api_service/get_storage_services.dart';
import 'package:spendlock/core/utils/app_snackbar.dart';
import 'package:spendlock/feature/auth/domain/repository/auth_repository.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  // repository
  final AuthRepository authRepository = AuthRepository.instance;

  Future<void> login() async {
    try {
      isLoading.value = true;
      if (emailController.text.trim().isEmpty ||
          passwordController.text.isEmpty) {
        AppSnackBar.error('Please enter email and password');
        return;
      }
      final response = await authRepository.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      if (response) {
        Get.offAllNamed(AppRoutes.instance.navigationScreen);
      } else {
        AppSnackBar.error('Login failed');
      }
    } catch (e) {
      AppSnackBar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> googleSignIn() async {
    isLoading.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 400));
    await GetStorageServices.instance.setToken('google_token');
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.instance.setGoalScreen);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
