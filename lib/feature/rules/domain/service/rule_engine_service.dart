import 'package:flutter/material.dart';
import 'package:spendlock/core/utils/rule_time_utils.dart';
import 'package:spendlock/feature/rules/domain/model/rule_model.dart';
import 'package:spendlock/feature/rules/domain/model/rule_type.dart';
import 'package:spendlock/feature/rules/domain/repository/rules_repository.dart';

class RuleEngineService {
  RuleEngineService._();

  static final RuleEngineService _instance = RuleEngineService._();
  static RuleEngineService get instance => _instance;

  /// Package name locked কিনা check করে active rule return করে
  RuleModel? findBlockingRule(String packageName) {
    final rules = RulesRepository.instance.getActiveRules();

    for (final rule in rules) {
      if (!rule.packageNames.contains(packageName)) continue;
      if (!isRuleActiveNow(rule)) continue;
      return rule;
    }

    return null;
  }

  /// Rule এখন enforce হচ্ছে কিনা check করে
  bool isRuleActiveNow(RuleModel rule) {
    if (!rule.isActive) return false;

    if (rule.isTimeBased) return _isTimeRuleActiveNow(rule);
    if (rule.isLimitBased) return _isLimitRuleActiveNow(rule);
    return false;
  }

  /// Time-based rule এখন active কিনা check করে (device local timezone)
  bool _isTimeRuleActiveNow(RuleModel rule) {
    final now = RuleTimeUtils.currentLocalNow;
    final todayIndex = RuleTimeUtils.todayDayIndex;

    if (!rule.activeDayIndices.contains(todayIndex)) return false;

    final currentMinutes = (now.hour * 60) + now.minute;
    final from = rule.timeFromMinutes;
    final to = rule.timeToMinutes;

    if (from == to) return true;

    if (from < to) {
      return currentMinutes >= from && currentMinutes <= to;
    }

    return currentMinutes >= from || currentMinutes <= to;
  }

  /// Limit-based rule active কিনা check করে
  bool _isLimitRuleActiveNow(RuleModel rule) {
    return rule.isActive && rule.packageNames.isNotEmpty;
  }

  /// Time-based rule এর remaining duration return করে
  Duration? getRemainingDuration(RuleModel rule) {
    if (!rule.isTimeBased) return null;

    final now = RuleTimeUtils.currentLocalNow;
    final currentMinutes = (now.hour * 60) + now.minute;
    final to = rule.timeToMinutes;
    final from = rule.timeFromMinutes;

    int remainingMinutes;

    if (from < to) {
      remainingMinutes = to - currentMinutes;
    } else if (currentMinutes >= from) {
      remainingMinutes = (24 * 60 - currentMinutes) + to;
    } else {
      remainingMinutes = to - currentMinutes;
    }

    if (remainingMinutes <= 0) return Duration.zero;
    return Duration(minutes: remainingMinutes);
  }

  /// Rule display text format করে
  String formatRuleTimeRange(RuleModel rule) {
    if (rule.isLimitBased) {
      final limit = rule.spendingLimit;
      if (limit == null) return 'Limit based rule';
      return '${limit.amount.toStringAsFixed(0)} ${_frequencyLabel(limit.frequency)}';
    }

    return '${_formatTime(rule.timeFrom)} - ${_formatTime(rule.timeTo)} · ${rule.timezoneLabel}';
  }

  static String formatRuleStatus(RuleModel rule) {
    return rule.isActive ? 'Active' : 'Inactive';
  }

  String formatRuleMessage(RuleModel rule) {
    if (rule.isLimitBased) {
      return "Your '${rule.name}' spending limit rule is currently active";
    }
    return "Your '${rule.name}' rule is currently active";
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  String _frequencyLabel(SpendingLimitFrequency frequency) {
    switch (frequency) {
      case SpendingLimitFrequency.perDay:
        return 'per day';
      case SpendingLimitFrequency.perWeek:
        return 'per week';
      case SpendingLimitFrequency.fullMonth:
        return 'per month';
    }
  }
}
