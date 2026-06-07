import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/component/appbar/custom_appbar.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/rules/presentation/controller/select_rule_apps_controller.dart';
import 'package:spendlock/feature/rules/presentation/widget/new_rule_step_badge.dart';
import 'package:spendlock/feature/rules/presentation/widget/selectable_app_list_tile.dart';

class SelectRuleAppsScreen extends GetView<SelectRuleAppsController> {
  const SelectRuleAppsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppbar(
        text: 'New Rule',
        centerTitle: false,
        action: [NewRuleStepBadge(currentStep: 3)],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            AppText(
              data: 'Select App',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'inter',
            ),
            SizedBox(height: 12.h),
            TextField(
              onChanged: controller.updateSearch,
              style: TextStyle(
                fontSize: 15.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.lightGray,
                ),
                prefixIcon: Icon(Icons.search, size: 22.sp, color: AppColors.gray),
                filled: true,
                fillColor: AppColors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: AppColors.stroke),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: AppColors.stroke),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: Obx(
                () {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }

                  final apps = controller.filteredApps;
                  if (apps.isEmpty) {
                    return Center(
                      child: AppText(
                        data: controller.searchQuery.value.trim().isEmpty
                            ? 'No installed apps found'
                            : 'No apps match your search',
                        fontSize: 14.sp,
                        color: AppColors.gray,
                        fontFamily: 'inter',
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: EdgeInsets.only(bottom: 16.h),
                    itemCount: apps.length,
                    separatorBuilder: (_, index) => SizedBox(height: 10.h),
                    itemBuilder: (context, index) {
                      final app = apps[index];
                      return Obx(
                        () => SelectableAppListTile(
                          app: app,
                          isSelected: controller.isSelected(app.id),
                          onTap: () => controller.toggleApp(app.id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Obx(
              () => AppButton(
                title: controller.isSaving.value ? 'Saving...' : 'Confirm',
                onTap: controller.hasSelection && !controller.isSaving.value
                    ? controller.confirm
                    : null,
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
