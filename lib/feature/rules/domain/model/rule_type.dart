import 'package:flutter/material.dart';

enum RuleType {
  timeBased,
  limitBased,
}

enum SpendingLimitFrequency {
  perDay,
  perWeek,
  fullMonth,
}

class SpendingLimitData {
  const SpendingLimitData({
    required this.amount,
    required this.frequency,
  });

  final double amount;
  final SpendingLimitFrequency frequency;
}

class TimeRangeData {
  const TimeRangeData({
    required this.from,
    required this.to,
  });

  final TimeOfDay from;
  final TimeOfDay to;
}

extension RuleTypeStorage on RuleType {
  int get storageIndex => index;

  static RuleType fromStorageIndex(int index) {
    return RuleType.values[index.clamp(0, RuleType.values.length - 1)];
  }
}

extension SpendingLimitFrequencyStorage on SpendingLimitFrequency {
  int get storageIndex => index;

  static SpendingLimitFrequency? fromStorageIndex(int? index) {
    if (index == null) return null;
    if (index < 0 || index >= SpendingLimitFrequency.values.length) {
      return null;
    }
    return SpendingLimitFrequency.values[index];
  }
}
