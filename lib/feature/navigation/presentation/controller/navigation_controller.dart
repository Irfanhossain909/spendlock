import 'package:get/get.dart';
import 'package:spendlock/feature/rules/presentation/controller/rules_controller.dart';
import 'package:spendlock/feature/streak/presentation/controller/streak_controller.dart';

class NavigationController extends GetxController {
  final selectedIndex = 0.obs;

  /// Bottom tab change করে; Rules tab এ গেলে list refresh করে
  void changeIndex(int index) {
    selectedIndex.value = index;

    if (index == 1) {
      RulesController.refreshList();
    }

    if (index == 3 && Get.isRegistered<StreakController>()) {
      Get.find<StreakController>().loadMonthDayRecords();
    }
  }
}
