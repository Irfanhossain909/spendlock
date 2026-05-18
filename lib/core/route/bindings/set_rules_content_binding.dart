import 'package:get/get.dart';
import 'package:spendlock/feature/rules/presentation/controller/set_rules_content_controller.dart';

class SetRulesContentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SetRulesContentController.new);
  }
}
