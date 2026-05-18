import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/app_image/app_image_circular.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/component/appbar/custom_appbar.dart';
import 'package:spendlock/core/const/app_assets.dart';
import 'package:spendlock/core/const/app_color.dart';

class ConnectAccountScreen extends StatelessWidget {
  const ConnectAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(text: 'Connect Account', centerTitle: false),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: AppButton(title: 'Add New Account', onTap: () {}),
        ),
      ),
      body: Column(
        spacing: 12.h,
        children: [BalabceCard(), BankCard(), BankCard()],
      ),
    );
  }
}

class BankCard extends StatelessWidget {
  const BankCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Row(
        spacing: 16.w,
        children: [
          AppImageCircular(
            path: AppAssets.mastercard,
            width: 40.w,
            height: 40.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                data: "Visa Card",
                fontSize: 14.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
              AppText(
                data: "••4521",
                fontSize: 12.sp,
                color: AppColors.gray,
                fontWeight: FontWeight.w500,
              ),
              Row(
                spacing: 4.w,
                children: [
                  Container(
                    width: 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  AppText(
                    data: "Connected · 2 min ago",
                    fontSize: 12.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BalabceCard extends StatelessWidget {
  const BalabceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Row(
        spacing: 16.w,
        children: [
          Container(
            margin: EdgeInsets.only(top: 4.h),
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColors.coinBg.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Icon(
              Icons.account_balance_wallet_outlined,
              size: 22.sp,
              color: Colors.orange,
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                data: "Total Balance across the account",
                fontSize: 10.sp,
                color: AppColors.white,
                fontWeight: FontWeight.w400,
              ),
              AppText(
                data: r"$12,487.50",
                fontSize: 22.sp,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
