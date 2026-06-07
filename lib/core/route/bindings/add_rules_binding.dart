import 'package:get/get.dart';
import 'package:spendlock/feature/rules/presentation/controller/add_rules_controller.dart';
import 'package:spendlock/feature/rules/presentation/controller/create_rule_session_controller.dart';

class AddRulesBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<CreateRuleSessionController>()) {
      Get.put(CreateRuleSessionController(), permanent: true);
    }
    Get.lazyPut(AddRulesController.new);
  }
}
