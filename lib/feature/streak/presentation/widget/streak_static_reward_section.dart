import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';

/// Static streak reward info below the calendar (matches design).
class StreakStaticRewardSection extends StatelessWidget {
  const StreakStaticRewardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 18.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.stroke),
          ),
          child: Column(
            children: [
              _IconRing(
                outer: AppColors.primaryMint,
                inner: AppColors.primary,
                child: Icon(Icons.check_rounded, color: AppColors.white, size: 24.sp),
              ),
              SizedBox(height: 12.h),
              AppText(
                data: '5 Day Streak',
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                fontFamily: 'hanken',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: AppText(
                  data: 'ACHIEVED',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.white,
                  fontFamily: 'hanken',
                  textAlign: TextAlign.center,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: AppColors.primaryMint,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: AppText(
            data: 'After 5 consecutive streak days, you\'ll receive 1 coin as reward',
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
            fontFamily: 'inter',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _IconRing extends StatelessWidget {
  const _IconRing({
    required this.outer,
    required this.inner,
    required this.child,
  });

  final Color outer;
  final Color inner;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52.w,
      height: 52.w,
      decoration: BoxDecoration(color: outer, shape: BoxShape.circle),
      child: Center(
        child: Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(color: inner, shape: BoxShape.circle),
          child: Center(child: child),
        ),
      ),
    );
  }
}
