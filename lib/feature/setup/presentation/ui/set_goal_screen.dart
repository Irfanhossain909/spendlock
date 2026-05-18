import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/component/selection_card.dart';
import 'package:spendlock/core/component/setup_progress_header.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/feature/setup/presentation/controller/setup_controller.dart';

class SetGoalScreen extends GetView<SetupController> {
  const SetGoalScreen({super.key});

  static const _goals = [
    (Icons.savings_outlined, 'Save more money', AppColors.primary),
    (Icons.remove_shopping_cart_outlined, 'Stop impulse buying', Colors.orange),
    (Icons.show_chart_rounded, 'Track spending', Colors.blueAccent),
    (Icons.bolt, 'Build better habits', AppColors.redBrown),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SetupProgressHeader(currentStep: 1, totalSteps: 5),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            AppText(
              data: "What's your goal?",
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: 8.h),
            AppText(
              data: "Choose the primary reason you're joining SpendLock today.",
              fontSize: 14.sp,
              color: AppColors.gray,
              maxLines: 3,
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: Obx(() {
                final selectedIndex = controller.selectedGoal.value;
                return ListView.separated(
                  itemCount: _goals.length,
                  separatorBuilder: (_, index) => SizedBox(height: 16.h),
                  itemBuilder: (_, i) {
                    final goal = _goals[i];
                    return SelectionCard(
                      title: goal.$2,
                      icon: goal.$1,
                      iconColor: goal.$3,
                      iconBgColor: goal.$3.withOpacity(0.1),
                      isSelected: selectedIndex == i,
                      onTap: () => controller.selectGoal(i),
                    );
                  },
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 24.h),
              child: AppButton(
                title: 'Continue',
                onTap: () => Get.toNamed(AppRoutes.instance.setChallengeScreen),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
