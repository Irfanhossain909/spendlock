import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onTap,
    required this.title,
    this.isLoading = false,
    this.height,
    this.width,
    this.backgroundColor,
    this.titleColor,
    this.titleSize,
    this.borderRadius,
    this.outlined = false,
    this.showArrow = false,
  });

  final VoidCallback? onTap;
  final String title;
  final bool isLoading;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? titleColor;
  final double? titleSize;
  final double? borderRadius;
  final bool outlined;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AppColors.primary;
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width ?? Get.width,
        height: height ?? 52.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: outlined ? Colors.transparent : bg,
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          border: outlined ? Border.all(color: AppColors.stroke) : null,
        ),
        child: isLoading
            ? SizedBox(
                height: 24.h,
                width: 24.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: outlined ? AppColors.primary : AppColors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    data: title,
                    color: titleColor ?? (outlined ? AppColors.black : AppColors.white),
                    fontWeight: FontWeight.w600,
                    fontSize: titleSize ?? 16.sp,
                    maxLines: 1,
                  ),
                  if (showArrow) ...[
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.arrow_forward,
                      color: titleColor ?? AppColors.white,
                      size: 18.sp,
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
