import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';

class SavingsStatBox extends StatelessWidget {
  const SavingsStatBox({
    super.key,
    required this.amount,
    required this.label,
  });

  final double amount;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.primaryMint,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              data: '\$${amount.toStringAsFixed(0)}',
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
              fontFamily: 'hanken',
            ),
            SizedBox(height: 4.h),
            AppText(
              data: label,
              fontSize: 11.sp,
              color: AppColors.gray,
              fontFamily: 'inter',
            ),
          ],
        ),
      ),
    );
  }
}
