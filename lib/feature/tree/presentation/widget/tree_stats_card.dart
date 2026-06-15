import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/tree/presentation/model/overview_model.dart';
import 'package:spendlock/feature/tree/presentation/widget/savings_stat_box.dart';
import 'package:spendlock/feature/tree/presentation/widget/segmented_progress_bar.dart';

class TreeStatsCard extends StatelessWidget {
  const TreeStatsCard({super.key, this.stats});

  final OverViewModel? stats;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.stroke),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            data: 'CURRENT STREAK',
            fontSize: 12.sp,
            color: AppColors.gray,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.7,
            fontFamily: 'hanken',
          ),
          SizedBox(height: 8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText(
                data: '${stats?.data?.currentStreak ?? 0}',
                fontSize: 36.sp,
                fontWeight: FontWeight.w700,
                fontFamily: 'hanken',
              ),
              SizedBox(width: 6.w),
              Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: AppText(
                  data: 'DAYS',
                  fontSize: 12.sp,
                  color: AppColors.gray,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'hanken',
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                data: 'Weekly Goal',
                fontSize: 11.sp,
                color: AppColors.darkGray,
                fontFamily: 'hanken',
                fontWeight: FontWeight.w600,
              ),
              AppText(
                data: '${getRemaining(stats?.data?.currentStreak ?? 0)}/5 Days',
                // data:
                //     '${stats.weeklyGoalProgress}/${stats.weeklyGoalTotal} Days',
                fontSize: 11.sp,
                color: AppColors.lightGray,
                fontFamily: 'inter',
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          SegmentedProgressBar(
            totalSegments: 5,
            completedSegments: getRemaining(stats?.data?.currentStreak ?? 0),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              SavingsStatBox(
                amount: stats?.data?.saveBalancePerMonth?.toDouble() ?? 0,
                label: 'saved this month',
              ),
              SizedBox(width: 12.w),
              SavingsStatBox(
                amount: stats?.data?.saveBalancePerMonth?.toDouble() ?? 0,
                label: 'total saved',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

int getRemaining(int? value) {
  return (value ?? 0) % 5;
}
