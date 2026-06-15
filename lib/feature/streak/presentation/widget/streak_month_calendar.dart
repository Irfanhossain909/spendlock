import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/streak/presentation/model/streak_calendar_day_tap.dart';
import 'package:spendlock/feature/streak/presentation/model/streak_day_status.dart';
import 'package:spendlock/feature/streak/presentation/model/streak_month_day_record.dart';
import 'package:spendlock/feature/streak/presentation/widget/streak_calendar_day_cell.dart';

const _weekdayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

const _monthNames = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

/// Month grid driven by [month] (year + month) and [dayRecords] for the list-backed styling.
class StreakMonthCalendar extends StatelessWidget {
  const StreakMonthCalendar({
    super.key,
    required this.month,
    required this.dayRecords,
    required this.onDayTap,
    this.today,
  });

  /// First day of the visible month.
  final DateTime month;

  /// Status per day-of-month for this [month].
  final List<StreakMonthDayRecord> dayRecords;

  final ValueChanged<StreakCalendarDayTap> onDayTap;

  /// Defaults to `DateTime.now()` (local).
  final DateTime? today;

  static int _daysInMonth(int year, int month) => DateTime(year, month + 1, 0).day;

  StreakDayStatus? _statusForDay(int day) {
    for (final r in dayRecords) {
      if (r.day == day) return r.status;
    }
    return null;
  }

  String _monthTitle() => '${_monthNames[month.month - 1]}, ${month.year}';

  @override
  Widget build(BuildContext context) {
    final now = today ?? DateTime.now();
    final y = month.year;
    final m = month.month;
    final dim = _daysInMonth(y, m);
    final first = DateTime(y, m, 1);
    final leading = first.weekday - 1; // Mon = 0
    final prevMonthDays = _daysInMonth(y, m - 1);
    final totalCells = ((leading + dim + 6) ~/ 7) * 7;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                data: 'This Month',
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                fontFamily: 'hanken',
              ),
              AppText(
                data: _monthTitle(),
                fontSize: 13.sp,
                color: AppColors.gray,
                fontFamily: 'inter',
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(12.w, 16.h, 12.w, 14.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.stroke),
          ),
          child: Column(
            children: [
              Row(
                children: _weekdayLabels
                    .map(
                      (w) => Expanded(
                        child: Center(
                          child: AppText(
                            data: w,
                            fontSize: 12.sp,
                            color: AppColors.lightGray,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'hanken',
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 8.h),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 6.h,
                  crossAxisSpacing: 6.w,
                  childAspectRatio: 1,
                ),
                itemCount: totalCells,
                itemBuilder: (context, index) {
                  if (index < leading) {
                    final d = prevMonthDays - leading + index + 1;
                    final py = m == 1 ? y - 1 : y;
                    final pm = m == 1 ? 12 : m - 1;
                    return StreakCalendarDayCell(
                      label: '$d',
                      status: null,
                      isToday: false,
                      isCurrentMonth: false,
                      year: py,
                      month: pm,
                      day: d,
                      onTap: onDayTap,
                    );
                  }
                  final currentDay = index - leading + 1;
                  if (currentDay <= dim) {
                    final isToday = now.year == y && now.month == m && now.day == currentDay;
                    return StreakCalendarDayCell(
                      label: '$currentDay',
                      status: _statusForDay(currentDay),
                      isToday: isToday,
                      isCurrentMonth: true,
                      year: y,
                      month: m,
                      day: currentDay,
                      onTap: onDayTap,
                    );
                  }
                  final nextDay = currentDay - dim;
                  final ny = m == 12 ? y + 1 : y;
                  final nm = m == 12 ? 1 : m + 1;
                  return StreakCalendarDayCell(
                    label: '$nextDay',
                    status: null,
                    isToday: false,
                    isCurrentMonth: false,
                    year: ny,
                    month: nm,
                    day: nextDay,
                    onTap: onDayTap,
                  );
                },
              ),
              SizedBox(height: 14.h),
              _LegendRow(
                items: [
                  _LegendDot(color: AppColors.primary, label: 'Success'),
                  _LegendDot(color: AppColors.coinUsedOrange, label: 'Coin Used'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({required this.items});

  final List<_LegendDot> items;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.w,
      runSpacing: 8.h,
      children: items
          .map(
            (e) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(color: e.color, shape: BoxShape.circle),
                ),
                SizedBox(width: 6.w),
                AppText(
                  data: e.label,
                  fontSize: 11.sp,
                  color: AppColors.gray,
                  fontFamily: 'inter',
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

class _LegendDot {
  const _LegendDot({required this.color, required this.label});

  final Color color;
  final String label;
}
