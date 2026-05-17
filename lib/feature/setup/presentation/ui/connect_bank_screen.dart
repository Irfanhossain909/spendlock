import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/component/setup_progress_header.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/core/route/app_routes.dart';

class ConnectBankScreen extends StatelessWidget {
  const ConnectBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SetupProgressHeader(currentStep: 4, totalSteps: 5),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 48.h),
            Container(
              width: 140.w,
              height: 140.w,
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Icon(Icons.account_balance_outlined, size: 64.sp, color: AppColors.primary),
            ),
            SizedBox(height: 32.h),
            AppText(
              data: 'Connect to your bank',
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            AppText(
              data:
                  'Securely link an account so we can track spending and enforce your rules in real time',
              fontSize: 14.sp,
              color: AppColors.gray,
              textAlign: TextAlign.center,
              maxLines: 4,
            ),
            const Spacer(),
            AppButton(
              title: 'Connect Bank',
              showArrow: true,
              onTap: () => Get.toNamed(AppRoutes.instance.budgetScreen),
            ),
            SizedBox(height: 12.h),
            AppButton(
              title: 'Skip for now',
              outlined: true,
              onTap: () => Get.toNamed(AppRoutes.instance.budgetScreen),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
