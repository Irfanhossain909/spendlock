import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_image/app_image_circular.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';

class SelectionCard extends StatelessWidget {
  const SelectionCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.imageUrl,
    required this.isSelected,
    required this.onTap,
    this.iconColor,
    this.iconBgColor,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final String? imageUrl;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? iconBgColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.stroke,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: iconBgColor ?? AppColors.primarySurface,
                borderRadius: BorderRadius.circular(8.r),
              ),
              clipBehavior: Clip.antiAlias,
              child: imageUrl != null && imageUrl!.isNotEmpty
                  ? AppImageCircular(
                      url: imageUrl,
                      width: 40.w,
                      height: 40.w,
                      borderRadius: 8.r,
                    )
                  : Icon(
                      icon ?? Icons.circle_outlined,
                      size: 20.sp,
                      color: iconColor ?? AppColors.primary,
                    ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    data: title,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'hanken',
                    maxLines: 2,
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 4.h),
                    AppText(
                      data: subtitle!,
                      fontSize: 13.sp,
                      color: AppColors.gray,
                      fontFamily: 'inter',
                      maxLines: 2,
                    ),
                  ],
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: AppColors.primary, size: 24.sp),
          ],
        ),
      ),
    );
  }
}
