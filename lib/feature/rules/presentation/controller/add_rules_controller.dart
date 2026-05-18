import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/feature/rules/presentation/model/rule_type.dart';

class AddRulesController extends GetxController {
  final selectedRuleType = Rxn<RuleType>();

  bool get canContinue => selectedRuleType.value != null;

  void selectRuleType(RuleType type) {
    selectedRuleType.value = type;
  }

  void continueToSetContent() {
    final type = selectedRuleType.value;
    if (type == null) return;

    Get.toNamed(
      AppRoutes.instance.setRulsContentScreen,
      arguments: type,
    );
  }
}
