import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/component/setup_progress_header.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/setup/presentation/controller/setup_controller.dart';
import 'package:spendlock/feature/setup/presentation/widget/monthly_limit_card.dart';

class BudgetScreen extends GetView<SetupController> {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetupController>(
      builder: (controller) {
        return Scaffold(
          appBar: const SetupProgressHeader(currentStep: 3, totalSteps: 5),
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
                  data:
                      "Define how much you'd like to spend each month to reach your goals faster.",
                  fontSize: 14.sp,
                  color: AppColors.gray,
                  maxLines: 3,
                ),
                SizedBox(height: 32.h),
                MonthlyLimitCard(
                  key: ValueKey(controller.monthlyBudget),
                  initialValue: controller.monthlyBudget,
                  min: 500,
                  max: 5000,
                  options: const [
                    BudgetOption(title: '\$1k', value: 1000),
                    BudgetOption(title: '\$2k', value: 2000),
                    BudgetOption(title: '\$3k', value: 3000),
                    BudgetOption(title: '\$5k', value: 5000),
                  ],
                  onChanged: controller.setBudget,
                ),
                const Spacer(),
                AppButton(
                  title: controller.isSaving ? 'Saving...' : 'Continue',
                  showArrow: !controller.isSaving,
                  onTap: controller.isSaving ? null : controller.saveBudget,
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
