import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/service/api_service/get_storage_services.dart';
import 'package:spendlock/core/utils/app_snackbar.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  Future<void> login() async {
    if (emailController.text.trim().isEmpty || passwordController.text.isEmpty) {
      AppSnackBar.error('Please enter email and password');
      return;
    }
    isLoading.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 600));
    await GetStorageServices.instance.setToken('demo_token');
    await GetStorageServices.instance.setName('Sarah Leo');
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.instance.setGoalScreen);
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
