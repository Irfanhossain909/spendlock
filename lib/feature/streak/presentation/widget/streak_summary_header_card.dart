import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';

/// Gradient “current streak” summary (coins, ON FIRE, big day count).
class StreakSummaryHeaderCard extends StatelessWidget {
  const StreakSummaryHeaderCard({
    super.key,
    required this.currentStreakDays,
    required this.coinBalance,
    this.onFire = true,
    this.onTap,
  });

  final int currentStreakDays;
  final int coinBalance;
  final bool onFire;
  final VoidCallback? onTap;

  String _formatCoins(int n) {
    final chars = n.toString().split('').reversed;
    final buf = StringBuffer();
    var i = 0;
    for (final c in chars) {
      if (i > 0 && i % 3 == 0) buf.write(',');
      buf.write(c);
      i++;
    }
    return buf.toString().split('').reversed.join();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Ink(
          padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 22.h),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF2FB8A8), Color(0xFF0A6B64)],
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: AppText(
                      data: 'CURRENT STREAK',
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: AppColors.white.withValues(alpha: 0.95),
                      fontFamily: 'hanken',
                    ),
                  ),
                  if (onFire)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.local_fire_department, size: 14.sp, color: AppColors.white),
                          SizedBox(width: 4.w),
                          AppText(
                            data: 'ON FIRE',
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.white,
                            fontFamily: 'hanken',
                          ),
                        ],
                      ),
                    ),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3C4),
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.monetization_on, size: 16.sp, color: AppColors.coinGold),
                        SizedBox(width: 4.w),
                        AppText(
                          data: _formatCoins(coinBalance),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.black,
                          fontFamily: 'hanken',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppText(
                    data: '$currentStreakDays',
                    fontSize: 48.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                    fontFamily: 'hanken',
                    height: 1,
                  ),
                  SizedBox(width: 10.w),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: AppText(
                      data: 'DAY STREAK',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white.withValues(alpha: 0.9),
                      fontFamily: 'hanken',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
