import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/service/api_service/get_storage_services.dart';
import 'package:spendlock/core/service/app_monitor/app_monitor_service.dart';
import 'package:spendlock/feature/rules/domain/repository/rules_repository.dart';

class ProfileController extends GetxController {
  String userName = '';
  String userEmail = '';

  @override
  void onInit() {
    super.onInit();
    refreshUserData();
  }

  void refreshUserData() {
    final storage = GetStorageServices.instance;
    userName = storage.getName();
    userEmail = storage.getEmail();
    update();
  }

  Future<void> logout() async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Log out?'),
        content: const Text(
          'You will be signed out and all locally saved lock data will be cleared.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Log out'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    if (Get.isRegistered<AppMonitorService>()) {
      await AppMonitorService.instance.stopMonitoring();
      await AppMonitorService.instance.resetGuardState();
    }

    await RulesRepository.instance.clearAllRules();
    await GetStorageServices.instance.clearSession();
    await GetStorageServices.instance.setOnboardingDone(true);

    Get.offAllNamed(AppRoutes.instance.loginScreen);
  }
}
