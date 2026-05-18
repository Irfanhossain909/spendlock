import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/feature/rules/presentation/model/rule_type.dart';

class SetRulesContentController extends GetxController {
  late final RuleType ruleType;

  final selectedCategoryIds = <String>{}.obs;
  final ruleName = ''.obs;

  final timeFrom = const TimeOfDay(hour: 21, minute: 0).obs;
  final timeTo = const TimeOfDay(hour: 8, minute: 0).obs;
  final activeDayIndices = <int>{1, 2, 3, 4, 5}.obs;

  final spendingLimit = SpendingLimitData(
    amount: 2000,
    frequency: SpendingLimitFrequency.perDay,
  ).obs;

  bool get isTimeBased => ruleType == RuleType.timeBased;
  bool get isLimitBased => ruleType == RuleType.limitBased;

  bool get canContinue {
    if (selectedCategoryIds.isEmpty || ruleName.value.trim().isEmpty) {
      return false;
    }
    if (isTimeBased && activeDayIndices.isEmpty) return false;
    return true;
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    ruleType = args is RuleType ? args : RuleType.timeBased;
  }

  void toggleCategory(String id) {
    if (selectedCategoryIds.contains(id)) {
      selectedCategoryIds.remove(id);
    } else {
      selectedCategoryIds.add(id);
    }
    selectedCategoryIds.refresh();
  }

  void updateRuleName(String value) {
    ruleName.value = value;
  }

  void updateTimeFrom(TimeOfDay time) {
    timeFrom.value = time;
  }

  void updateTimeTo(TimeOfDay time) {
    timeTo.value = time;
  }

  void toggleActiveDay(int index) {
    if (activeDayIndices.contains(index)) {
      activeDayIndices.remove(index);
    } else {
      activeDayIndices.add(index);
    }
    activeDayIndices.refresh();
  }

  void updateSpendingLimit(SpendingLimitData data) {
    spendingLimit.value = data;
  }

  void onContinue() {
    if (!canContinue) return;
    Get.toNamed(AppRoutes.instance.selectRuleAppsScreen);
  }
}
