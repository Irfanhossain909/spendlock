import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/service/api_service/get_storage_services.dart';

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
    await GetStorageServices.instance.clearSession();
    await GetStorageServices.instance.setOnboardingDone(true);
    Get.offAllNamed(AppRoutes.instance.loginScreen);
  }
}
