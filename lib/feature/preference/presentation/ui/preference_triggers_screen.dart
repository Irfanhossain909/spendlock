import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/appbar/custom_appbar.dart';
import 'package:spendlock/core/component/selection_card.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/core/const/preference_options.dart';
import 'package:spendlock/feature/preference/presentation/controller/preference_controller.dart';

class PreferenceTriggersScreen extends GetView<PreferenceController> {
  const PreferenceTriggersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreferenceController>(
      builder: (controller) {
        final selected = Set<int>.from(controller.selectedChallenges);

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: const CustomAppbar(
            text: 'My triggers',
            centerTitle: false,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                Expanded(
                  child: ListView.separated(
                    itemCount: PreferenceOptions.triggers.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (_, i) {
                      final item = PreferenceOptions.triggers[i];
                      return SelectionCard(
                        title: item.$2,
                        icon: item.$1,
                        iconColor: item.$3,
                        iconBgColor: item.$3.withValues(alpha: 0.1),
                        isSelected: selected.contains(i),
                        onTap: () => controller.toggleChallenge(i),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 24.h, top: 12.h),
                  child: AppButton(
                    title: 'Save',
                    onTap: controller.saveTriggers,
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
