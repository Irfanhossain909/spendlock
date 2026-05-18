import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';

class ActiveDaysSelector extends StatelessWidget {
  const ActiveDaysSelector({
    super.key,
    required this.selectedIndices,
    required this.onDayToggled,
    this.dayLabels = const ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
  });

  final Set<int> selectedIndices;
  final ValueChanged<int> onDayToggled;
  final List<String> dayLabels;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          data: 'Active days',
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'inter',
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dayLabels.length, (index) {
            final isSelected = selectedIndices.contains(index);

            return GestureDetector(
              onTap: () => onDayToggled(index),
              child: Container(
                width: 40.w,
                height: 40.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.stroke,
                  ),
                ),
                child: AppText(
                  data: dayLabels[index],
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? AppColors.white : AppColors.gray,
                  fontFamily: 'inter',
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
