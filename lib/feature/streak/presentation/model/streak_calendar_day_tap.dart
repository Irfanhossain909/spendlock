import 'package:spendlock/feature/streak/presentation/model/streak_day_status.dart';

/// Payload when user taps a calendar cell (current month day or trailing cell).
class StreakCalendarDayTap {
  const StreakCalendarDayTap({
    required this.year,
    required this.month,
    required this.day,
    this.status,
    required this.isCurrentMonth,
  });

  final int year;
  final int month;
  final int day;

  /// Status from the streak list when this day is in the visible month and listed.
  final StreakDayStatus? status;
  final bool isCurrentMonth;
}
