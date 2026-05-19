import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_image/app_image_circular.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/profile/presentation/model/app_usage_item.dart';

class AppUsageListTile extends StatelessWidget {
  const AppUsageListTile({super.key, required this.item});

  final AppUsageItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _AppIcon(item: item),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  data: item.name,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'inter',
                ),
                SizedBox(height: 2.h),
                AppText(
                  data: item.category,
                  fontSize: 12.sp,
                  color: AppColors.gray,
                  fontFamily: 'inter',
                ),
              ],
            ),
          ),
          AppText(
            data: item.value,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            fontFamily: 'hanken',
          ),
        ],
      ),
    );
  }
}

class _AppIcon extends StatelessWidget {
  const _AppIcon({required this.item});

  final AppUsageItem item;

  @override
  Widget build(BuildContext context) {
    if (item.iconPath != null) {
      return AppImageCircular(
        path: item.iconPath,
        width: 40.w,
        height: 40.w,
        borderRadius: 12.r,
        fit: BoxFit.cover,
      );
    }

    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: item.iconBackground?.withValues(alpha: 0.12) ??
            AppColors.primarySurface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(
        item.iconData ?? Icons.apps,
        size: 22.sp,
        color: item.iconBackground ?? AppColors.primary,
      ),
    );
  }
}
