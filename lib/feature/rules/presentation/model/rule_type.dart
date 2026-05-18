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
