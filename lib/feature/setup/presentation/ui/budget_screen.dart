import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/component/setup_progress_header.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/setup/presentation/controller/setup_controller.dart';

class BudgetScreen extends GetView<SetupController> {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SetupProgressHeader(currentStep: 5, totalSteps: 5),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            AppText(
              data: 'Set your monthly budget',
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: 8.h),
            AppText(
              data: "Define how much you'd like to spend each month to reach your goals faster.",
              fontSize: 14.sp,
              color: AppColors.gray,
              maxLines: 3,
            ),
            SizedBox(height: 32.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(32.w),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Obx(
                () => Column(
                  children: [
                    AppText(
                      data: 'Monthly Limit',
                      fontSize: 14.sp,
                      color: AppColors.white.withValues(alpha: 0.9),
                      fontFamily: 'inter',
                    ),
                    SizedBox(height: 8.h),
                    AppText(
                      data: '\$${controller.monthlyBudget.value.toInt()}',
                      fontSize: 48.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
                      fontFamily: 'inter',
                    ),
                    SizedBox(height: 24.h),
                    Slider(
                      value: controller.monthlyBudget.value,
                      min: 500,
                      max: 5000,
                      divisions: 18,
                      activeColor: AppColors.white,
                      inactiveColor: AppColors.white.withValues(alpha: 0.3),
                      onChanged: controller.setBudget,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            AppButton(
              title: 'Finish Setup',
              showArrow: true,
              onTap: controller.completeSetup,
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
