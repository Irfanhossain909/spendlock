import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';

class TimeRangePickerRow extends StatelessWidget {
  const TimeRangePickerRow({
    super.key,
    required this.from,
    required this.to,
    required this.onFromChanged,
    required this.onToChanged,
    this.timezoneLabel,
  });

  final TimeOfDay from;
  final TimeOfDay to;
  final ValueChanged<TimeOfDay> onFromChanged;
  final ValueChanged<TimeOfDay> onToChanged;
  final String? timezoneLabel;

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  Future<void> _pickTime(
    BuildContext context, {
    required TimeOfDay initial,
    required ValueChanged<TimeOfDay> onChanged,
  }) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: AppColors.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          data: 'Time range',
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'inter',
        ),
        if (timezoneLabel != null) ...[
          SizedBox(height: 4.h),
          AppText(
            data: 'Device timezone: $timezoneLabel',
            fontSize: 12.sp,
            color: AppColors.gray,
            fontFamily: 'inter',
          ),
        ],
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: _TimeField(
                label: 'From',
                value: _formatTime(from),
                onTap: () => _pickTime(
                  context,
                  initial: from,
                  onChanged: onFromChanged,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _TimeField(
                label: 'To',
                value: _formatTime(to),
                onTap: () => _pickTime(
                  context,
                  initial: to,
                  onChanged: onToChanged,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TimeField extends StatelessWidget {
  const _TimeField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.stroke),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    data: label,
                    fontSize: 11.sp,
                    color: AppColors.gray,
                    fontFamily: 'inter',
                  ),
                  SizedBox(height: 2.h),
                  AppText(
                    data: value,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'inter',
                  ),
                ],
              ),
            ),
            Icon(Icons.keyboard_arrow_down, size: 20.sp, color: AppColors.gray),
          ],
        ),
      ),
    );
  }
}
