import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_image/app_image_circular.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/rules/presentation/model/selectable_app_item.dart';

class SelectableAppListTile extends StatelessWidget {
  const SelectableAppListTile({
    super.key,
    required this.app,
    required this.isSelected,
    required this.onTap,
  });

  final SelectableAppItem app;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.stroke),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(4.w),
                child: _AppIcon(app: app),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      data: app.name,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'inter',
                    ),
                    SizedBox(height: 2.h),
                    AppText(
                      data: app.category,
                      fontSize: 12.sp,
                      color: AppColors.gray,
                      fontFamily: 'inter',
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 22.w,
                height: 22.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.lightGray,
                    width: 1.5,
                  ),
                  color: isSelected ? AppColors.primary : Colors.transparent,
                ),
                child: isSelected
                    ? Icon(Icons.check, size: 14.sp, color: AppColors.white)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppIcon extends StatelessWidget {
  const _AppIcon({required this.app});

  final SelectableAppItem app;

  @override
  Widget build(BuildContext context) {
    if (app.iconBytes != null) {
      return AppImageCircular(
        path: null,
        width: 38.w,
        height: 38.w,
        borderRadius: 12.r,
        fit: BoxFit.cover,
        memoryBytes: app.iconBytes,
      );
    }

    return AppImageCircular(
      path: app.icon,
      width: 38.w,
      height: 38.w,
      borderRadius: 12.r,
      fit: BoxFit.cover,
    );
  }
}
