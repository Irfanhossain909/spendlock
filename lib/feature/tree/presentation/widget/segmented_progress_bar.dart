import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/const/app_color.dart';

class SegmentedProgressBar extends StatelessWidget {
  const SegmentedProgressBar({
    super.key,
    required this.totalSegments,
    required this.completedSegments,
  });

  final int totalSegments;
  final int completedSegments;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSegments, (index) {
        final filled = index < completedSegments;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: index < totalSegments - 1 ? 6.w : 0),
            height: 6.h,
            decoration: BoxDecoration(
              color: filled ? AppColors.primary : const Color(0x3364748B),
              borderRadius: BorderRadius.circular(999.r),
            ),
          ),
        );
      }),
    );
  }
}
