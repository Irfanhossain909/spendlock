import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_assets.dart';
import 'package:spendlock/core/const/app_color.dart';

class CoinBalanceCard extends StatelessWidget {
  const CoinBalanceCard({
    super.key,
    required this.balance,
    this.showBuyButton = false,
    this.onBuyTap,
  });

  final int balance;
  final bool showBuyButton;
  final VoidCallback? onBuyTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFD54F), AppColors.coinGold],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.coinGold.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              AppAssets.coin,
              width: 24.w,
              height: 24.h,
              color: AppColors.black,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  data: 'CURRENT BALANCE',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  color: AppColors.black.withValues(alpha: 0.55),
                  fontFamily: 'hanken',
                ),
                SizedBox(height: 4.h),
                AppText(
                  data: '$balance coins',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.black,
                  fontFamily: 'hanken',
                ),
              ],
            ),
          ),
          if (showBuyButton)
            GestureDetector(
              onTap: onBuyTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: AppText(
                  data: 'Buy Coin',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                  fontFamily: 'hanken',
                ),
              ),
            ),
        ],
      ),
    );
  }
}
