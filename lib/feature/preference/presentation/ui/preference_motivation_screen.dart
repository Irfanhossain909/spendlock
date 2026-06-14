import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/appbar/custom_appbar.dart';
import 'package:spendlock/core/component/selection_card.dart';
import 'package:spendlock/core/const/app_color.dart';
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
                  child: controller.isLoadingMotivation
                      ? const Center(child: CircularProgressIndicator())
                      : controller.motivationList.isEmpty
                          ? Center(
                              child: Text(
                                'No motivation options found.',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.gray,
                                ),
                              ),
                            )
                          : ListView.separated(
                              itemCount: controller.motivationList.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 12.h),
                              itemBuilder: (_, index) {
                                final item = controller.motivationList[index];
                                final id = item.id;
                                if (id == null) return const SizedBox.shrink();

                                return SelectionCard(
                                  title: item.title ?? '',
                                  imageUrl: item.image,
                                  icon: Icons.track_changes_outlined,
                                  iconColor: Colors.amber.shade700,
                                  iconBgColor:
                                      Colors.amber.shade700.withValues(alpha: 0.1),
                                  isSelected:
                                      controller.selectedMotivationId == id,
                                  onTap: () => controller.selectMotivation(id),
                                );
                              },
                            ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 24.h, top: 12.h),
                  child: AppButton(
                    title: controller.isSaving ? 'Saving...' : 'Save',
                    onTap: controller.isSaving ? null : controller.saveMotivation,
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
