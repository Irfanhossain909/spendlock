import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/service/api_service/get_storage_services.dart';
import 'package:spendlock/core/utils/app_snackbar.dart';

class VerifyEmailController extends GetxController {
  final isLoading = false.obs;

  Future<void> verify(String code) async {
    if (code.length < 4) {
      AppSnackBar.error('Enter the 4-digit code');
      return;
    }
    isLoading.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 500));
    await GetStorageServices.instance.setToken('verified_token');
    await GetStorageServices.instance.setName('Sarah Leo');
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.instance.setGoalScreen);
  }
}
