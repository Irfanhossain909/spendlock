import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/appbar/custom_appbar.dart';
import 'package:spendlock/core/component/selection_card.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/preference/presentation/controller/preference_controller.dart';

class PreferenceTriggersScreen extends GetView<PreferenceController> {
  const PreferenceTriggersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreferenceController>(
      builder: (controller) {
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
                                  SizedBox(height: 12.h),
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
                  padding: EdgeInsets.only(bottom: 24.h, top: 12.h),
                  child: AppButton(
                    title: controller.isSaving ? 'Saving...' : 'Save',
                    onTap: controller.isSaving ? null : controller.saveTriggers,
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
