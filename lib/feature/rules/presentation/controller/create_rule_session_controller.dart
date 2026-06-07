import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/utils/rule_time_utils.dart';
import 'package:spendlock/feature/rules/domain/model/rule_model.dart';
import 'package:spendlock/feature/rules/domain/model/rule_type.dart';

class CreateRuleSessionController extends GetxController {
  RuleType ruleType = RuleType.timeBased;
  final categoryIds = <String>{};
  String ruleName = '';
  TimeOfDay timeFrom = RuleTimeUtils.deviceNowTimeOfDay;
  TimeOfDay timeTo = RuleTimeUtils.deviceDefaultEndTimeOfDay;
  final activeDayIndices = <int>{};
  SpendingLimitData spendingLimit = const SpendingLimitData(
    amount: 2000,
    frequency: SpendingLimitFrequency.perDay,
  );
  final selectedPackageNames = <String>[];
  String timezoneName = RuleTimeUtils.deviceTimezoneName;
  int timezoneOffsetMinutes = RuleTimeUtils.deviceTimezoneOffsetMinutes;

  /// নতুন rule flow শুরু করার আগে session reset করে
  void reset() {
    ruleType = RuleType.timeBased;
    categoryIds.clear();
    ruleName = '';
    timeFrom = RuleTimeUtils.deviceNowTimeOfDay;
    timeTo = RuleTimeUtils.deviceDefaultEndTimeOfDay;
    activeDayIndices
      ..clear()
      ..addAll(RuleTimeUtils.defaultActiveDayIndices);
    spendingLimit = const SpendingLimitData(
      amount: 2000,
      frequency: SpendingLimitFrequency.perDay,
    );
    selectedPackageNames.clear();
    timezoneName = RuleTimeUtils.deviceTimezoneName;
    timezoneOffsetMinutes = RuleTimeUtils.deviceTimezoneOffsetMinutes;
  }

  /// Step 1: rule type save করে
  void setRuleType(RuleType type) {
    ruleType = type;
  }

  /// Step 2: category, name, time/limit data save করে
  void saveContent({
    required Set<String> categories,
    required String name,
    required TimeOfDay from,
    required TimeOfDay to,
    required Set<int> days,
    required SpendingLimitData limit,
    required String timezoneName,
    required int timezoneOffsetMinutes,
  }) {
    categoryIds
      ..clear()
      ..addAll(categories);
    ruleName = name.trim();
    timeFrom = from;
    timeTo = to;
    activeDayIndices
      ..clear()
      ..addAll(days);
    spendingLimit = limit;
    this.timezoneName = timezoneName;
    this.timezoneOffsetMinutes = timezoneOffsetMinutes;
  }

  /// Step 3: selected app package names save করে
  void setSelectedPackageNames(List<String> packageNames) {
    selectedPackageNames
      ..clear()
      ..addAll(packageNames);
  }

  /// Session data থেকে Hive-ready RuleModel build করে
  RuleModel buildRuleModel() {
    return RuleModel(
      id: RuleTimeUtils.currentLocalNow.millisecondsSinceEpoch.toString(),
      type: ruleType.storageIndex,
      name: ruleName,
      categoryIds: categoryIds.toList(),
      timeFromMinutes: RuleModel.timeOfDayToMinutes(timeFrom),
      timeToMinutes: RuleModel.timeOfDayToMinutes(timeTo),
      activeDayIndices: activeDayIndices.toList(),
      spendingLimitAmount:
          ruleType == RuleType.limitBased ? spendingLimit.amount : null,
      spendingLimitFrequency: ruleType == RuleType.limitBased
          ? spendingLimit.frequency.storageIndex
          : null,
      packageNames: List<String>.from(selectedPackageNames),
      isActive: true,
      createdAtMillis: RuleTimeUtils.currentLocalNow.millisecondsSinceEpoch,
      timezoneName: timezoneName,
      timezoneOffsetMinutes: timezoneOffsetMinutes,
    );
  }
}
