import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:spendlock/feature/streak/domain/repository/streak_repository.dart';
import 'package:spendlock/feature/streak/presentation/model/streak_calendar_day_tap.dart';
import 'package:spendlock/feature/streak/presentation/model/streak_day_status.dart';
import 'package:spendlock/feature/streak/presentation/model/streak_model.dart';
import 'package:spendlock/feature/streak/presentation/model/streak_month_day_record.dart';

class StreakController extends GetxController {
  final StreakRepository _streakRepository = StreakRepository.instance;

  final currentStreak = 0.obs;
  final coinBalance = 0.obs;
  final isLoading = false.obs;

  /// Day-of-month + status for the **running** calendar month.
  final monthDayRecords = <StreakMonthDayRecord>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMonthDayRecords();
  }

  Future<void> loadMonthDayRecords() async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      final response = await _streakRepository.getStreak();
      if (response == null) {
        monthDayRecords.clear();
        return;
      }

      if (response.currentStreak != null) {
        currentStreak.value = response.currentStreak!;
      }
      if (response.coinBalance != null) {
        coinBalance.value = response.coinBalance!;
      }

      final now = DateTime.now();
      final byDay = <int, StreakDayStatus>{};

      for (final datum in response.data ?? <Datum>[]) {
        final date = datum.date;
        final status = datum.status;
        if (date == null || status == null) continue;
        if (date.year != now.year || date.month != now.month) continue;

        final dayStatus = switch (status) {
          Status.progress => StreakDayStatus.progress,
          Status.break_ => StreakDayStatus.break_,
        };

        byDay[date.day] = _mergeDayStatus(byDay[date.day], dayStatus);
      }

      final records = byDay.entries
          .map((e) => StreakMonthDayRecord(day: e.key, status: e.value))
          .toList();

      monthDayRecords.assignAll(records);
    } finally {
      isLoading.value = false;
    }
  }

  /// Same calendar day can appear more than once in API data — break wins.
  static StreakDayStatus _mergeDayStatus(
    StreakDayStatus? existing,
    StreakDayStatus incoming,
  ) {
    if (existing == StreakDayStatus.break_ || incoming == StreakDayStatus.break_) {
      return StreakDayStatus.break_;
    }
    return incoming;
  }

  void onCalendarDayTap(StreakCalendarDayTap tap) {
    if (kDebugMode) {
      debugPrint(
        'Streak calendar: ${tap.year}-${tap.month}-${tap.day} '
        'inMonth=${tap.isCurrentMonth} status=${tap.status}',
      );
    }
  }
}
