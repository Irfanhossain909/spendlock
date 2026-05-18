import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:spendlock/feature/streak/presentation/model/milestone_card_state.dart';
import 'package:spendlock/feature/streak/presentation/model/milestone_item.dart';
import 'package:spendlock/feature/streak/presentation/model/streak_calendar_day_tap.dart';
import 'package:spendlock/feature/streak/presentation/model/streak_day_status.dart';
import 'package:spendlock/feature/streak/presentation/model/streak_month_day_record.dart';

class StreakController extends GetxController {
  final currentStreak = 12.obs;
  final longestStreak = 18.obs;
  final coinBalance = 5000.obs;

  /// Day-of-month + status for the **running** calendar month (see [seedMonthRecords]).
  final monthDayRecords = <StreakMonthDayRecord>[].obs;

  final milestones = <MilestoneItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    seedMonthRecords();
    _seedMilestones();
  }

  /// Replace with API data — keys are days in the current month only.
  void seedMonthRecords() {
    final now = DateTime.now();
    final records = <StreakMonthDayRecord>[];
    for (var d = 1; d < now.day; d++) {
      if (d == 6) {
        records.add(StreakMonthDayRecord(day: d, status: StreakDayStatus.broken));
      } else if (d == 11) {
        records.add(StreakMonthDayRecord(day: d, status: StreakDayStatus.coinUsed));
      } else if (d <= 5 || (d >= 7 && d <= 10)) {
        records.add(StreakMonthDayRecord(day: d, status: StreakDayStatus.success));
      }
    }
    monthDayRecords.assignAll(records);
  }

  void _seedMilestones() {
    milestones.assignAll([
      const MilestoneItem(id: 'm7', title: '7 Day Streak', state: MilestoneCardState.achieved),
      MilestoneItem(
        id: 'm14',
        title: '14 Day Streak',
        state: MilestoneCardState.inProgress,
        progress: (currentStreak.value / 14).clamp(0.0, 1.0),
      ),
      const MilestoneItem(id: 'm30', title: '30 Day Streak', state: MilestoneCardState.locked),
    ]);
  }

  /// Calendar cell tap — receives date + optional status from [monthDayRecords].
  void onCalendarDayTap(StreakCalendarDayTap tap) {
    if (kDebugMode) {
      debugPrint(
        'Streak calendar: ${tap.year}-${tap.month}-${tap.day} '
        'inMonth=${tap.isCurrentMonth} status=${tap.status}',
      );
    }
  }

  void onMilestoneTap(MilestoneItem item) {
    if (kDebugMode) {
      debugPrint('Milestone: ${item.id} (${item.state})');
    }
  }
}
