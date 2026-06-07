import 'package:flutter/material.dart';

class RuleTimeUtils {
  RuleTimeUtils._();

  /// Device local DateTime (timezone-aware)
  static DateTime get currentLocalNow => DateTime.now();

  /// Device local start time — এখনকার সময়
  static TimeOfDay get deviceNowTimeOfDay {
    final now = currentLocalNow;
    return TimeOfDay(hour: now.hour, minute: now.minute);
  }

  /// Device local end time — এখন + 2 ঘণ্টা
  static TimeOfDay get deviceDefaultEndTimeOfDay {
    final end = currentLocalNow.add(const Duration(hours: 2));
    return TimeOfDay(hour: end.hour, minute: end.minute);
  }

  /// ActiveDaysSelector index: 0=Sun ... 6=Sat
  static int get todayDayIndex => currentLocalNow.weekday % 7;

  /// Default active day — আজকের দিন select
  static Set<int> get defaultActiveDayIndices => {todayDayIndex};

  /// Device timezone name (e.g. BST, GMT+6)
  static String get deviceTimezoneName => currentLocalNow.timeZoneName;

  /// Device timezone offset in minutes
  static int get deviceTimezoneOffsetMinutes =>
      currentLocalNow.timeZoneOffset.inMinutes;

  /// UI display label (e.g. BST (UTC+06:00))
  static String get deviceTimezoneLabel {
    final offset = currentLocalNow.timeZoneOffset;
    final sign = offset.isNegative ? '-' : '+';
    final totalMinutes = offset.inMinutes.abs();
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    final paddedHours = hours.toString().padLeft(2, '0');
    final paddedMinutes = minutes.toString().padLeft(2, '0');
    return '$deviceTimezoneName (UTC$sign$paddedHours:$paddedMinutes)';
  }

  /// Minutes since midnight from local TimeOfDay
  static int toMinutes(TimeOfDay time) => (time.hour * 60) + time.minute;

  /// Local TimeOfDay from stored minutes
  static TimeOfDay fromMinutes(int minutes) {
    final normalized = minutes % (24 * 60);
    return TimeOfDay(hour: normalized ~/ 60, minute: normalized % 60);
  }
}
