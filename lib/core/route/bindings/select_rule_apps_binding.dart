import 'package:get/get.dart';
import 'package:spendlock/feature/rules/presentation/controller/select_rule_apps_controller.dart';

class SelectRuleAppsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SelectRuleAppsController.new);
  }
}
