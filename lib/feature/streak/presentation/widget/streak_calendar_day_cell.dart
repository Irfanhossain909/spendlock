import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/streak/presentation/model/streak_calendar_day_tap.dart';
import 'package:spendlock/feature/streak/presentation/model/streak_day_status.dart';

/// Single calendar day cell — style driven by status / today / outside month.
class StreakCalendarDayCell extends StatelessWidget {
  const StreakCalendarDayCell({
    super.key,
    required this.label,
    required this.onTap,
    this.status,
    required this.isToday,
    required this.isCurrentMonth,
    required this.year,
    required this.month,
    required this.day,
  });

  final String label;
  final ValueChanged<StreakCalendarDayTap> onTap;
  final StreakDayStatus? status;
  final bool isToday;
  final bool isCurrentMonth;
  final int year;
  final int month;
  final int day;

  @override
  Widget build(BuildContext context) {
    final child = Center(
      child: AppText(
        data: label,
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'hanken',
        textAlign: TextAlign.center,
        color: _textColor(),
      ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap(
          StreakCalendarDayTap(
            year: year,
            month: month,
            day: day,
            status: isCurrentMonth ? status : null,
            isCurrentMonth: isCurrentMonth,
          ),
        ),
        borderRadius: BorderRadius.circular(8.r),
        child: DecoratedBox(
          decoration: _decoration(),
          child: child,
        ),
      ),
    );
  }

  Color? _textColor() {
    if (!isCurrentMonth) {
      return AppColors.lightGray;
    }
    if (isToday) return AppColors.primary;
    switch (status) {
      case StreakDayStatus.progress:
      case StreakDayStatus.break_:
        return AppColors.white;
      case null:
        return AppColors.lightGray;
    }
  }

  BoxDecoration _decoration() {
    if (!isCurrentMonth) {
      return const BoxDecoration();
    }
    if (isToday) {
      return BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.primary, width: 2),
      );
    }
    switch (status) {
      case StreakDayStatus.progress:
        return BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8.r),
        );
      case StreakDayStatus.break_:
        return BoxDecoration(
          color: AppColors.coinUsedOrange,
          borderRadius: BorderRadius.circular(8.r),
        );
      case null:
        return const BoxDecoration();
    }
  }
}
