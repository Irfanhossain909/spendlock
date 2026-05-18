import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/appbar/custom_appbar.dart';
import 'package:spendlock/core/component/selection_card.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/core/const/preference_options.dart';
import 'package:spendlock/feature/preference/presentation/controller/preference_controller.dart';

class PreferenceMotivationScreen extends GetView<PreferenceController> {
  const PreferenceMotivationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreferenceController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: const CustomAppbar(
            text: 'My motivation',
            centerTitle: false,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                Expanded(
                  child: ListView.separated(
                    itemCount: PreferenceOptions.goals.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (_, i) {
                      final goal = PreferenceOptions.goals[i];
                      return SelectionCard(
                        title: goal.$2,
                        icon: goal.$1,
                        iconColor: goal.$3,
                        iconBgColor: goal.$3.withValues(alpha: 0.1),
                        isSelected: controller.selectedGoal == i,
                        onTap: () => controller.selectGoal(i),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 24.h, top: 12.h),
                  child: AppButton(
                    title: 'Save',
                    onTap: controller.saveMotivation,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
