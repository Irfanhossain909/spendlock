import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/utils/rule_time_utils.dart';
import 'package:spendlock/feature/rules/presentation/controller/create_rule_session_controller.dart';
import 'package:spendlock/feature/rules/presentation/model/rule_type.dart';

class SetRulesContentController extends GetxController {
  late final RuleType ruleType;

  final selectedCategoryIds = <String>{}.obs;
  final ruleName = ''.obs;

  late final TimeOfDay _initialFrom;
  late final TimeOfDay _initialTo;
  late final Rx<TimeOfDay> timeFrom;
  late final Rx<TimeOfDay> timeTo;
  final activeDayIndices = <int>{}.obs;
  final timezoneLabel = RuleTimeUtils.deviceTimezoneLabel.obs;

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
    _initialFrom = RuleTimeUtils.deviceNowTimeOfDay;
    _initialTo = RuleTimeUtils.deviceDefaultEndTimeOfDay;
    timeFrom = _initialFrom.obs;
    timeTo = _initialTo.obs;
    _syncDeviceLocalDefaults();
  }

  /// Device local timezone + current time দিয়ে default values set করে
  void _syncDeviceLocalDefaults() {
    timezoneLabel.value = RuleTimeUtils.deviceTimezoneLabel;

    if (!isTimeBased) return;

    timeFrom.value = _initialFrom;
    timeTo.value = _initialTo;
    activeDayIndices
      ..clear()
      ..addAll(RuleTimeUtils.defaultActiveDayIndices);
    activeDayIndices.refresh();
  }

  /// Category toggle করে
  void toggleCategory(String id) {
    if (selectedCategoryIds.contains(id)) {
      selectedCategoryIds.remove(id);
    } else {
      selectedCategoryIds.add(id);
    }
    selectedCategoryIds.refresh();
  }

  /// Rule name update করে
  void updateRuleName(String value) {
    ruleName.value = value;
  }

  /// Start time update করে
  void updateTimeFrom(TimeOfDay time) {
    timeFrom.value = time;
  }

  /// End time update করে
  void updateTimeTo(TimeOfDay time) {
    timeTo.value = time;
  }

  /// Active day toggle করে
  void toggleActiveDay(int index) {
    if (activeDayIndices.contains(index)) {
      activeDayIndices.remove(index);
    } else {
      activeDayIndices.add(index);
    }
    activeDayIndices.refresh();
  }

  /// Spending limit update করে
  void updateSpendingLimit(SpendingLimitData data) {
    spendingLimit.value = data;
  }

  /// Content session এ save করে app selection screen এ navigate করে
  void onContinue() {
    if (!canContinue) return;

    Get.find<CreateRuleSessionController>().saveContent(
      categories: selectedCategoryIds.toSet(),
      name: ruleName.value,
      from: timeFrom.value,
      to: timeTo.value,
      days: activeDayIndices.toSet(),
      limit: spendingLimit.value,
      timezoneName: RuleTimeUtils.deviceTimezoneName,
      timezoneOffsetMinutes: RuleTimeUtils.deviceTimezoneOffsetMinutes,
    );

    Get.toNamed(AppRoutes.instance.selectRuleAppsScreen);
  }
}
