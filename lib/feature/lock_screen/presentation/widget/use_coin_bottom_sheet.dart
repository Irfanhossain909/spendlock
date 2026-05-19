import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_assets.dart';
import 'package:spendlock/core/const/app_color.dart';

class UseCoinBottomSheet extends StatelessWidget {
  const UseCoinBottomSheet({
    super.key,
    required this.coinsLeft,
    this.onConfirm,
  });

  final int coinsLeft;
  final VoidCallback? onConfirm;

  static Future<void> show(
    BuildContext context, {
    required int coinsLeft,
    VoidCallback? onConfirm,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => UseCoinBottomSheet(
        coinsLeft: coinsLeft,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.lightGray.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7E0),
                borderRadius: BorderRadius.circular(14.r),
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                AppAssets.coin,
                width: 32.w,
                height: 32.h,
              ),
            ),
            SizedBox(height: 16.h),
            AppText(
              data: 'Use a coin?',
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            AppText(
              data:
                  'This will override your rule once.\nYour streak stays safe.',
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.gray,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            SizedBox(height: 24.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F7F9),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.stroke.withValues(alpha: 0.5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    data: 'Time Remaining',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    spacing: 8.w,
                    children: [
                      SvgPicture.asset(
                        AppAssets.coin,
                        width: 24.w,
                        height: 24.h,
                      ),
                      AppText(
                        data: '$coinsLeft',
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            AppButton(
              title: 'Yes, use coin',
              borderRadius: 28.r,
              onTap: () {
                Navigator.of(context).pop();
                onConfirm?.call();
              },
            ),
            SizedBox(height: 8.h),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: AppText(
                data: 'Cancel',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.gray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
