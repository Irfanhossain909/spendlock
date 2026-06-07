import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/component/auth_form_card.dart';
import 'package:spendlock/core/component/spendlock_branding.dart';
import 'package:spendlock/core/const/app_assets.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/lock_screen/presentation/controller/lock_screen_controller.dart';
import 'package:spendlock/feature/lock_screen/presentation/widget/use_coin_bottom_sheet.dart';

class LockScreen extends GetView<LockScreenController> {
  const LockScreen({super.key});

  static const int _coinsLeft = 12;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) controller.closeLockScreen();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16.h,
              children: [
                const SpendLockBranding(logoSize: 123),
                AppText(
                  data: 'SpendLock',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
                AppText(
                  data: 'Hold On!',
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w800,
                ),
                SizedBox(
                  width: 250.w,
                  child: Obx(
                    () => AppText(
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      data: controller.ruleMessage.value,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.gray,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                AuthFormCard(
                  child: Column(
                    spacing: 12.h,
                    children: [
                      AppText(
                        data: 'Time Remaining',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      Obx(
                        () => AppText(
                          data: controller.remainingText.value,
                          fontSize: 42.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border(
                      left: BorderSide(color: AppColors.primary, width: 3.w),
                    ),
                  ),
                  child: Row(
                    spacing: 12.w,
                    children: [
                      SvgPicture.asset(AppAssets.container),
                      Expanded(
                        child: AppText(
                          data:
                              'Are you really hungry, or just bored? Try drinking water and waiting 15 minutes',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => UseCoinBottomSheet.show(
                    context,
                    coinsLeft: _coinsLeft,
                    onConfirm: controller.closeLockScreen,
                  ),
                  child: AuthFormCard(
                    horizontalPadding: 12.w,
                    verticalPadding: 16.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 12.w,
                      children: [
                        SvgPicture.asset(AppAssets.coin),
                        AppText(
                          data: 'Use Coin to Override ($_coinsLeft left)',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12.sp,
                          color: AppColors.coinGold,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ),
                AppText(
                  data: 'Skipping will break your 12-day streak',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16.sp,
                  color: AppColors.lightGray,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
