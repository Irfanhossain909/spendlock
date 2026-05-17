import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/service/api_service/get_storage_services.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    final storage = GetStorageServices.instance;
    if (storage.getToken().isNotEmpty || storage.getIsGuest()) {
      if (storage.getSetupDone()) {
        Get.offAllNamed(AppRoutes.instance.navigationScreen);
      } else {
        Get.offAllNamed(AppRoutes.instance.setGoalScreen);
      }
      return;
    }
    if (storage.getOnboardingDone()) {
      Get.offAllNamed(AppRoutes.instance.loginScreen);
      return;
    }
    Get.offAllNamed(AppRoutes.instance.onboardingScreen);
  }
}
