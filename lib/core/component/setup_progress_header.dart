import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/const/app_color.dart';

class SetupProgressHeader extends StatelessWidget implements PreferredSizeWidget {
  const SetupProgressHeader({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.onBack,
  });

  final int currentStep;
  final int totalSteps;
  final VoidCallback? onBack;

  @override
  Size get preferredSize => Size.fromHeight(64.h);

  @override
  Widget build(BuildContext context) {
    final progress = currentStep / totalSteps;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
        child: Row(
          children: [
            GestureDetector(
              onTap: onBack ?? () => Get.back(),
              child: Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.stroke),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Icons.arrow_back_ios_new, size: 14.sp, color: AppColors.black),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(999.r),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8.h,
                  backgroundColor: AppColors.stroke,
                  color: AppColors.primary,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              '$currentStep/$totalSteps',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.gray,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
