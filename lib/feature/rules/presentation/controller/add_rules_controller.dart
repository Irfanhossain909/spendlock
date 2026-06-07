import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/feature/rules/presentation/controller/create_rule_session_controller.dart';
import 'package:spendlock/feature/rules/presentation/model/rule_type.dart';

class AddRulesController extends GetxController {
  final selectedRuleType = Rxn<RuleType>();

  bool get canContinue => selectedRuleType.value != null;

  @override
  void onInit() {
    super.onInit();
    Get.find<CreateRuleSessionController>().reset();
  }

  /// Rule type select করে
  void selectRuleType(RuleType type) {
    selectedRuleType.value = type;
  }

  /// Selected type session এ save করে next step এ navigate করে
  void continueToSetContent() {
    final type = selectedRuleType.value;
    if (type == null) return;

    Get.find<CreateRuleSessionController>().setRuleType(type);
    Get.toNamed(
      AppRoutes.instance.setRulsContentScreen,
      arguments: type,
    );
  }
}
