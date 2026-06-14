import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/coin/domain/model/coin_transaction_item.dart';

class CoinTransactionTile extends StatelessWidget {
  const CoinTransactionTile({super.key, required this.item});

  final CoinTransactionItem item;

  @override
  Widget build(BuildContext context) {
    final amountPrefix = item.isPositive ? '+' : '';
    final amountColor = item.isPositive ? AppColors.primary : AppColors.red;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: item.iconBackground,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(item.icon, size: 22.sp, color: item.iconColor),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  data: item.title,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'hanken',
                  maxLines: 2,
                ),
                SizedBox(height: 4.h),
                AppText(
                  data: item.subtitle,
                  fontSize: 13.sp,
                  color: AppColors.gray,
                  fontFamily: 'inter',
                  maxLines: 2,
                ),
                SizedBox(height: 4.h),
                AppText(
                  data: item.timestamp,
                  fontSize: 12.sp,
                  color: AppColors.lightGray,
                  fontFamily: 'inter',
                ),
              ],
            ),
          ),
          AppText(
            data: '$amountPrefix${item.amount}',
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: amountColor,
            fontFamily: 'hanken',
          ),
        ],
      ),
    );
  }
}
