import 'package:spendlock/feature/streak/presentation/model/streak_day_status.dart';

/// One day in the visible month with a known status (from API / local list).
class StreakMonthDayRecord {
  const StreakMonthDayRecord({
    required this.day,
    required this.status,
  });

  /// Day of month (1–31).
  final int day;
  final StreakDayStatus status;
}
