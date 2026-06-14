import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/appbar/custom_appbar.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/preference/presentation/controller/preference_controller.dart';
import 'package:spendlock/feature/setup/presentation/widget/monthly_limit_card.dart';

class PreferenceBudgetScreen extends GetView<PreferenceController> {
  const PreferenceBudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreferenceController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: const CustomAppbar(
            text: 'Monthly budget',
            centerTitle: false,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 24.h),
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
                  title: controller.isSaving ? 'Saving...' : 'Save',
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
