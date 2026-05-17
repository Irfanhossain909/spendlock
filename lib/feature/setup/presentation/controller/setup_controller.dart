import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/service/api_service/get_storage_services.dart';

class SetupController extends GetxController {
  final selectedGoal = 0.obs;
  final selectedChallenges = <int>[0].obs;
  final monthlyBudget = 2000.0.obs;

  void selectGoal(int index) => selectedGoal.value = index;

  void toggleChallenge(int index) {
    if (selectedChallenges.contains(index)) {
      if (selectedChallenges.length > 1) {
        selectedChallenges.remove(index);
      }
    } else {
      selectedChallenges.add(index);
    }
    selectedChallenges.refresh();
  }

  void setBudget(double value) => monthlyBudget.value = value;

  Future<void> completeSetup() async {
    await GetStorageServices.instance.setSetupDone(true);
    Get.offAllNamed(AppRoutes.instance.navigationScreen);
  }
}
