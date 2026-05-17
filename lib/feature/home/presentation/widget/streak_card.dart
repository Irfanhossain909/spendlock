import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';

class StreakCard extends StatelessWidget {
  const StreakCard({
    super.key,
    required this.streakDays,
    required this.weeklyProgress,
  });

  final int streakDays;
  final int weeklyProgress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
                        data: '$streakDays',
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
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryMint,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: AppText(
                  data: '🔥 ON FIRE',
                  fontSize: 10.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'hanken',
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Icon(Icons.park, size: 80.sp, color: AppColors.primary),
          SizedBox(height: 16.h),
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
                data: '$weeklyProgress/7 Days',
                fontSize: 11.sp,
                color: AppColors.lightGray,
                fontFamily: 'inter',
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: List.generate(7, (i) {
              final filled = i < weeklyProgress;
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: i < 6 ? 6.w : 0),
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: filled
                        ? AppColors.primary
                        : const Color(0x3364748B),
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
