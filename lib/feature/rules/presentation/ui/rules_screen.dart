import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/feature/rules/presentation/controller/rules_controller.dart';
import 'package:spendlock/feature/rules/presentation/model/rule_item.dart';
import 'package:spendlock/feature/rules/presentation/widget/rule_card.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = RulesController.to;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(
          () {
            final filter = controller.selectedFilter.value;
            final allRules = controller.rules.toList();
            final filtered = controller.filteredRulesFor(filter);
            final isLoading = controller.isLoading.value;

            if (isLoading && allRules.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
                  child: AppText(
                    data: 'Rules',
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'hanken',
                  ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _FilterChip(
                                label: 'All',
                                selected: filter == RulesFilter.all,
                                onTap: () => controller.changeFilter(RulesFilter.all),
                              ),
                              SizedBox(width: 8.w),
                              _FilterChip(
                                label: 'Active',
                                selected: filter == RulesFilter.active,
                                onTap: () => controller.changeFilter(RulesFilter.active),
                              ),
                              SizedBox(width: 8.w),
                              _FilterChip(
                                label: 'Paused',
                                selected: filter == RulesFilter.paused,
                                onTap: () => controller.changeFilter(RulesFilter.paused),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Material(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12.r),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.instance.addRulsScreen);
                          },
                          borderRadius: BorderRadius.circular(12.r),
                          child: SizedBox(
                            width: 44.w,
                            height: 44.w,
                            child: Icon(Icons.add, color: AppColors.white, size: 24.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: AppText(
                    data: 'My Rules (${filtered.length})',
                    fontSize: 14.sp,
                    color: AppColors.gray,
                    fontFamily: 'inter',
                  ),
                ),
                SizedBox(height: 12.h),
                Expanded(
                  child: filtered.isEmpty
                      ? Center(
                          child: AppText(
                            data: filter == RulesFilter.all
                                ? 'No rules yet. Tap + to create one.'
                                : 'No rules found',
                            fontSize: 14.sp,
                            color: AppColors.gray,
                            fontFamily: 'inter',
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 100.h),
                          itemCount: filtered.length,
                          separatorBuilder: (_, index) => SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            final rule = filtered[index];

                            return RuleCard(
                              title: rule.title,
                              time: rule.time,
                              socialName: rule.socialName,
                              duration: rule.duration,
                              statusLabel: rule.statusLabel,
                              icon: rule.icon,
                              iconBgColor: rule.iconBgColor,
                              badgeType: rule.badgeType,
                              socialIcons: rule.socialIcons,
                              isActive: rule.isActive,
                              onToggleChanged: (value) =>
                                  controller.toggleRule(rule.id, value),
                              onDelete: () => controller.deleteRule(rule.id),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.black : AppColors.white,
          borderRadius: BorderRadius.circular(999.r),
          border: Border.all(
            color: selected ? AppColors.black : AppColors.stroke,
          ),
        ),
        child: AppText(
          data: label,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: selected ? AppColors.white : AppColors.gray,
          fontFamily: 'inter',
        ),
      ),
    );
  }
}
