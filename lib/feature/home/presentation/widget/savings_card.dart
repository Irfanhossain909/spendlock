import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';

class SavingsCard extends StatelessWidget {
  const SavingsCard({super.key, required this.amount});

  final double amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 124.h,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 8.h,
            child: Icon(
              Icons.account_balance_wallet_outlined,
              size: 72.sp,
              color: AppColors.white.withValues(alpha: 0.25),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                data: 'Total Saving this month',
                fontSize: 14.sp,
                color: AppColors.white,
                fontFamily: 'inter',
              ),
              SizedBox(height: 8.h),
              AppText(
                data: '\$${amount.toStringAsFixed(2)}',
                fontSize: 32.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.white,
                fontFamily: 'inter',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
