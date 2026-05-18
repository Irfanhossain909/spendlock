import 'package:get/get.dart';
import 'package:spendlock/feature/rules/presentation/controller/add_rules_controller.dart';

class AddRulesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AddRulesController.new);
  }
}
