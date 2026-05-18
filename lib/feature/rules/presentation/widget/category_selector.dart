import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/rules/presentation/model/rule_category.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedIds,
    required this.onCategoryToggled,
  });

  final List<RuleCategory> categories;
  final Set<String> selectedIds;
  final ValueChanged<String> onCategoryToggled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          data: 'Select categories',
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'inter',
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 88.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (_, index) {
              final category = categories[index];
              final isSelected = selectedIds.contains(category.id);

              return GestureDetector(
                onTap: () => onCategoryToggled(category.id),
                child: Container(
                  width: 72.w,
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.stroke,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 36.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          color: category.iconBgColor ?? AppColors.primarySurface,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          category.icon,
                          size: 20.sp,
                          color: category.iconColor ?? AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      AppText(
                        data: category.label,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? AppColors.primary : AppColors.gray,
                        fontFamily: 'inter',
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
