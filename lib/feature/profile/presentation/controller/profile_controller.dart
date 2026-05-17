import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/service/api_service/get_storage_services.dart';

class ProfileController extends GetxController {
  final userName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    userName.value = GetStorageServices.instance.getName();
  }

  Future<void> logout() async {
    await GetStorageServices.instance.clearSession();
    await GetStorageServices.instance.setOnboardingDone(true);
    Get.offAllNamed(AppRoutes.instance.loginScreen);
  }
}
