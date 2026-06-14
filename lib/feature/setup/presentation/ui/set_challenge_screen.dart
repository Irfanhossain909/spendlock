import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/component/selection_card.dart';
import 'package:spendlock/core/component/setup_progress_header.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/setup/presentation/controller/setup_controller.dart';

class SetChallengeScreen extends GetView<SetupController> {
  const SetChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetupController>(
      builder: (controller) {
        return Scaffold(
          appBar: const SetupProgressHeader(currentStep: 2, totalSteps: 5),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                AppText(
                  data: "What's your biggest challenge?",
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  maxLines: 2,
                ),
                SizedBox(height: 8.h),
                AppText(
                  data:
                      'Select one that best describes your spending challenge.',
                  fontSize: 14.sp,
                  color: AppColors.gray,
                  maxLines: 3,
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: controller.isLoadingTrigger
                      ? const Center(child: CircularProgressIndicator())
                      : controller.triggerList.isEmpty
                          ? Center(
                              child: Text(
                                'No trigger options found.',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.gray,
                                ),
                              ),
                            )
                          : ListView.separated(
                              itemCount: controller.triggerList.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 16.h),
                              itemBuilder: (_, index) {
                                final item = controller.triggerList[index];
                                final id = item.id;
                                if (id == null) return const SizedBox.shrink();

                                return SelectionCard(
                                  title: item.title ?? '',
                                  imageUrl: item.image,
                                  icon: Icons.bolt_outlined,
                                  iconColor: Colors.pinkAccent,
                                  iconBgColor:
                                      Colors.pinkAccent.withValues(alpha: 0.1),
                                  isSelected: controller.selectedTriggerId == id,
                                  onTap: () => controller.selectTrigger(id),
                                );
                              },
                            ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 24.h),
                  child: AppButton(
                    title: controller.isSaving ? 'Saving...' : 'Continue',
                    showArrow: !controller.isSaving,
                    onTap: controller.isSaving ? null : controller.saveTrigger,
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
