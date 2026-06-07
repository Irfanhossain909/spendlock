import 'package:get/get.dart';
import 'package:spendlock/core/service/app_monitor/app_monitor_service.dart';
import 'package:spendlock/feature/home/presentation/controller/home_controller.dart';
import 'package:spendlock/feature/navigation/presentation/controller/navigation_controller.dart';
import 'package:spendlock/feature/profile/presentation/controller/profile_controller.dart';
import 'package:spendlock/feature/rules/presentation/controller/create_rule_session_controller.dart';
import 'package:spendlock/feature/rules/presentation/controller/rules_controller.dart';
import 'package:spendlock/feature/streak/presentation/controller/streak_controller.dart';
import 'package:spendlock/feature/tree/presentation/controller/tree_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CreateRuleSessionController(), permanent: true);
    AppMonitorService.instance;
    RulesController.to;
    Get.lazyPut(NavigationController.new);
    Get.lazyPut(HomeController.new);
    Get.lazyPut(TreeController.new);
    Get.lazyPut(StreakController.new);
    Get.lazyPut(ProfileController.new);
  }
}
